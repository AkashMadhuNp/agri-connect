import 'package:agri/core/service/nursery_service.dart';
import 'package:flutter/material.dart';

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
