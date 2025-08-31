// presentation/widgets/nursery/nursery_widgets.dart
import 'package:flutter/material.dart';
import 'package:agri/core/service/nursery_service.dart';

class QuickStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const QuickStatCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF757575),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RevenueCard extends StatelessWidget {
  final double revenue;
  final String growthPercentage;
  final VoidCallback? onTap;

  const RevenueCard({
    Key? key,
    required this.revenue,
    required this.growthPercentage,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nurseryService = NurseryService();
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [Color(0xFF66BB6A), Color(0xFF4CAF50)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'This Month Revenue',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const Icon(
                    Icons.trending_up,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                nurseryService.formatCurrency(revenue),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                growthPercentage,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

class ActivityCard extends StatelessWidget {
  final Map<String, dynamic> activity;
  final VoidCallback? onTap;

  const ActivityCard({
    Key? key,
    required this.activity,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: activity['color'].withOpacity(0.2),
          child: Icon(
            activity['icon'],
            color: activity['color'],
            size: 20,
          ),
        ),
        title: Text(
          activity['title'],
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        subtitle: Text('${activity['subtitle']} • ${activity['time']}'),
        onTap: onTap,
      ),
    );
  }
}

class NurseryAppBar extends StatelessWidget {
  final String greeting;
  final String userName;
  final bool isLoadingUser;
  final int notificationCount;
  final VoidCallback? onNotificationTap;
  final Size screenSize;

  const NurseryAppBar({
    Key? key,
    required this.greeting,
    required this.userName,
    required this.isLoadingUser,
    required this.notificationCount,
    this.onNotificationTap,
    required this.screenSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nurseryService = NurseryService();
    final dimensions = nurseryService.getResponsiveDimensions(screenSize);
    
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: screenSize.height > 700 ? 140 : 120,
      floating: false,
      pinned: true,
      backgroundColor: const Color(0xFF2E7D32),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF4CAF50),
                Color(0xFF2E7D32),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: dimensions['horizontalPadding']!),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: screenSize.height > 700 ? 20 : 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              greeting,
                              style: TextStyle(
                                fontSize: dimensions['subtitleFontSize'],
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            isLoadingUser
                                ? SizedBox(
                                    width: screenSize.width * 0.4,
                                    height: dimensions['headerFontSize']! * 0.7,
                                    child: const LinearProgressIndicator(
                                      backgroundColor: Colors.white30,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      userName,
                                      style: TextStyle(
                                        fontSize: dimensions['headerFontSize'],
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                            Text(
                              'Nursery Owner',
                              style: TextStyle(
                                fontSize: dimensions['subtitleFontSize'],
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: dimensions['avatarSize'],
                        height: dimensions['avatarSize'],
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.2),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.account_circle,
                          color: Colors.white,
                          size: dimensions['avatarSize']! * 0.5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.height > 700 ? 20 : 12),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: dimensions['horizontalPadding']! - 8),
          child: Stack(
            children: [
              IconButton(
                icon: Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: dimensions['iconSize'],
                ),
                onPressed: onNotificationTap,
              ),
              if (notificationCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$notificationCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final double fontSize;

  const SectionHeader({
    Key? key,
    required this.title,
    this.buttonText,
    this.onButtonPressed,
    this.fontSize = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2D3142),
          ),
        ),
        if (buttonText != null)
          TextButton(
            onPressed: onButtonPressed,
            child: Text(buttonText!),
          ),
      ],
    );
  }
}