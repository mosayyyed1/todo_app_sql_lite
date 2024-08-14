class ToDoItem {
  int id;
  String title;
  String description;
  DateTime dueDate;

  ToDoItem({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.millisecondsSinceEpoch,
    };
  }

  ToDoItem.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'] ?? '',
        dueDate = DateTime.fromMillisecondsSinceEpoch(map['dueDate']);
}
