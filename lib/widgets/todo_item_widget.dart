import 'package:flutter/material.dart';

import '../models/todo_item.dart';

class ToDoItemWidget extends StatelessWidget {
  final ToDoItem item;

  const ToDoItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        tileColor: Colors.white,
        leading: const Icon(
          Icons.circle_outlined,
          color: Colors.deepPurple,
          size: 28,
        ),
        title: Text(
          item.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          item.description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          '${item.dueDate.toLocal()}'.split(' ')[0],
          style: const TextStyle(
            fontSize: 14,
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}
