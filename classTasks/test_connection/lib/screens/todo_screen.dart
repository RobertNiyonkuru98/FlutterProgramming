import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/todo_service.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _editController = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _editController.dispose();
    super.dispose();
  }

  void _addTodo() async {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      try {
        await TodoService.addTodo(text);

        _controller.clear();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Todo added successfully!')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error adding todo: $e')),
          );
        }
      }
    }
  }

  void _toggleTodo(String id, bool currentStatus) async {
    try {
      await TodoService.toggleTodo(id, currentStatus);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating todo: $e')),
        );
      }
    }
  }

  void _deleteTodo(String id) async {
    try {
      await TodoService.deleteTodo(id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Todo deleted!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting todo: $e')),
        );
      }
    }
  }

  void _editTodo(DocumentSnapshot todo) {
    final data = todo.data() as Map<String, dynamic>?;
    _editController.text = (data != null && data.containsKey('task')) ? todo['task'] : '';

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit Todo'),
        content: TextField(
          controller: _editController,
          decoration: const InputDecoration(hintText: 'Enter new task'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final newText = _editController.text.trim();
              if (newText.isNotEmpty) {
                try {
                  await TodoService.updateTodo(todo.id, newText);

                  if (dialogContext.mounted) {
                    Navigator.pop(dialogContext);
                  }
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Todo updated!')),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error updating todo: $e')),
                    );
                  }
                }
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteCompletedTodos() async {
    try {
      await TodoService.deleteCompletedTodos();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Completed todos cleared!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error clearing completed todos: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Todo App'),
        actions: [
          // Logout button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final authService = Provider.of<AuthService>(context, listen: false);
              await authService.signOut();
            },
            tooltip: 'Logout',
          ),
          // Clear completed button
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: _deleteCompletedTodos,
            tooltip: 'Clear Completed',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter new task',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addTodo(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTodo,
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: TodoService.getTodosStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final todos = snapshot.data?.docs ?? [];

                if (todos.isEmpty) {
                  return const Center(
                    child: Text('No todos yet! Add a new todo to get started.'),
                  );
                }

                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    final data = todo.data() as Map<String, dynamic>?;
                    final bool isCompleted = (data != null && data.containsKey('completed'))
                        ? (data['completed'] ?? false)
                        : false;
                    final String taskText = (data != null && data.containsKey('task'))
                        ? (data['task'] ?? '')
                        : '';

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: ListTile(
                        leading: Checkbox(
                          value: isCompleted,
                          onChanged: (_) => _toggleTodo(todo.id, isCompleted),
                        ),
                        title: Text(
                          taskText,
                          style: TextStyle(
                            decoration: isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _editTodo(todo),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteTodo(todo.id),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
