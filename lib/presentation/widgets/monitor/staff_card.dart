import 'package:agri/core/model/staff_model.dart';
import 'package:flutter/material.dart';

class StaffCardWidget extends StatelessWidget {
  final StaffMember staff;
  final VoidCallback? onCallPressed;
  final VoidCallback? onAssignTaskPressed;

  const StaffCardWidget({
    super.key,
    required this.staff,
    this.onCallPressed,
    this.onAssignTaskPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      staff.avatar,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            staff.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Chip(
                            label: Text(
                              staff.status,
                              style: const TextStyle(fontSize: 10),
                            ),
                            backgroundColor: _getStaffStatusColor(staff.status)
                                .withOpacity(0.2),
                          ),
                        ],
                      ),
                      Text(
                        staff.role,
                        style: const TextStyle(
                          color: Color(0xFF4CAF50),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        staff.currentTask,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Assigned Sections:',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              children: staff.assignedSections
                  .map<Widget>(
                    (section) => Chip(
                      label: Text(section, style: const TextStyle(fontSize: 10)),
                      backgroundColor: const Color(0xFF4CAF50).withOpacity(0.1),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tasks: ${staff.completedTasks}/${staff.todaysTasks}',
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  staff.phone,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF4CAF50),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onCallPressed,
                    icon: const Icon(Icons.call, size: 16),
                    label: const Text('Call', style: TextStyle(fontSize: 12)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF4CAF50),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onAssignTaskPressed,
                    icon: const Icon(Icons.assignment, size: 16),
                    label: const Text(
                      'Assign Task',
                      style: TextStyle(fontSize: 12),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStaffStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'on duty':
        return Colors.green;
      case 'available':
        return Colors.blue;
      case 'busy':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}