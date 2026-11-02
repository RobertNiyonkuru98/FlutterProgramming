import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TodoService {
  static FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  // User-specific collection: each user gets their own todos subcollection
  static CollectionReference get _todosCollection {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('No user logged in');
    }
    return _firestore.collection('users').doc(userId).collection('todos');
  }

  static Future<DocumentReference> addTodo(String task) async {
    return await _todosCollection.add({
      'task': task,
      'completed': false,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  static Stream<QuerySnapshot> getTodosStream() {
    return _todosCollection
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  static Future<void> toggleTodo(String id, bool currentStatus) async {
    await _todosCollection.doc(id).update({
      'completed': !currentStatus,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> updateTodo(String id, String newTask) async {
    await _todosCollection.doc(id).update({
      'task': newTask,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> deleteTodo(String id) async {
    await _todosCollection.doc(id).delete();
  }

  static Future<void> deleteCompletedTodos() async {
    final querySnapshot = await _todosCollection
        .where('completed', isEqualTo: true)
        .get();

    final batch = _firestore.batch();
    for (final doc in querySnapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}
