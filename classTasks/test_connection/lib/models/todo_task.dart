class TodoTask {
  final String id;
  final String title;
  final bool isCompleted;
  final DateTime createdAt;

  TodoTask({
    required this.id,
    required this.title,
    this.isCompleted = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isCompleted': isCompleted,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory TodoTask.fromMap(String id, Map<String, dynamic> map) {
    DateTime parsedDate;
    if (map['createdAt'] is int) {
      parsedDate = DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int);
    } else {
      parsedDate = DateTime.now();
    }

    return TodoTask(
      id: id,
      title: map['title'] as String? ?? '',
      isCompleted: map['isCompleted'] as bool? ?? false,
      createdAt: parsedDate,
    );
  }

  TodoTask copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return TodoTask(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
