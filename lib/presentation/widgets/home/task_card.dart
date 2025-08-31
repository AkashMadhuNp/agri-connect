import 'package:agri/core/service/nursery_service.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final Map<String, dynamic> task;
  final VoidCallback? onTap;

  const TaskCard({
    Key? key,
    required this.task,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nurseryService = NurseryService();
    final priorityColor = nurseryService.getPriorityColor(task['priority']);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: priorityColor.withOpacity(0.2),
          child: Icon(
            Icons.task_alt,
            color: priorityColor,
            size: 18,
          ),
        ),
        title: Text(
          task['task'],
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        subtitle: Text('${task['due']} • ${task['assigned']}'),
        trailing: Chip(
          label: Text(
            task['priority'],
            style: const TextStyle(fontSize: 10),
          ),
          backgroundColor: priorityColor.withOpacity(0.2),
          side: BorderSide(color: priorityColor),
        ),
        onTap: onTap,
      ),
    );
  }
}
