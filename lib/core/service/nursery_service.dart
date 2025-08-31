import 'package:flutter/material.dart';

class NurseryService {
  static final NurseryService _instance = NurseryService._internal();
  factory NurseryService() => _instance;
  NurseryService._internal();

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  Map<String, dynamic> getNurseryStats() {
    return {
      'activeProduction': 12,
      'readyForSale': 2400,
      'pendingOrders': 8,
      'monthlyRevenue': 45600,
      'lowStockItems': 3,
      'staffOnDuty': 5
    };
  }

  List<Map<String, dynamic>> getTodaysTasks() {
    return [
      {
        'task': 'Water greenhouse section A',
        'priority': 'High',
        'due': '10:00 AM',
        'assigned': 'Ravi Kumar'
      },
      {
        'task': 'Check tomato seedlings for pests',
        'priority': 'Medium',
        'due': '2:00 PM',
        'assigned': 'Dr. Sarah'
      },
      {
        'task': 'Prepare soil mix for new batch',
        'priority': 'Low',
        'due': '4:00 PM',
        'assigned': 'Unassigned'
      },
      {
        'task': 'Client visit - Sharma Farm',
        'priority': 'High',
        'due': '11:30 AM',
        'assigned': 'You'
      },
    ];
  }

  List<Map<String, dynamic>> getRecentActivities() {
    return [
      {
        'type': 'sale',
        'title': 'Sold 500 tomato seedlings',
        'subtitle': 'Patel Farm - Rs. 7,500',
        'time': '2 hours ago',
        'icon': Icons.shopping_cart,
        'color': Colors.green
      },
      {
        'type': 'alert',
        'title': 'Low inventory alert',
        'subtitle': 'Corn seeds - 5 kg remaining',
        'time': '4 hours ago',
        'icon': Icons.warning,
        'color': Colors.orange
      },
      {
        'type': 'consultation',
        'title': 'Consultation completed',
        'subtitle': 'Soil analysis for Gupta Farm',
        'time': '6 hours ago',
        'icon': Icons.assignment_turned_in,
        'color': Colors.blue
      },
      {
        'type': 'production',
        'title': 'Batch ready for harvest',
        'subtitle': '300 pepper plants - Section B',
        'time': '1 day ago',
        'icon': Icons.agriculture,
        'color': Colors.purple
      },
    ];
  }

  Future<Map<String, dynamic>> fetchNurseryStatsFromAPI() async {
 
    await Future.delayed(const Duration(seconds: 1));
    return getNurseryStats();
  }

  Future<List<Map<String, dynamic>>> fetchTodaysTasksFromAPI() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return getTodaysTasks();
  }

  Future<List<Map<String, dynamic>>> fetchRecentActivitiesFromAPI() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return getRecentActivities();
  }

  String formatCurrency(double amount) {
    if (amount >= 1000000) {
      return 'Rs. ${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return 'Rs. ${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return 'Rs. ${amount.toStringAsFixed(0)}';
    }
  }

  Map<String, double> getResponsiveDimensions(Size screenSize) {
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    
    return {
      'horizontalPadding': screenWidth > 600 ? 20 : 14,
      'sectionSpacing': screenHeight > 700 ? 20 : 14,
      'titleFontSize': screenWidth > 600 ? 20 : 18,
      'headerFontSize': screenWidth > 600 ? 28 : 20,
      'subtitleFontSize': screenWidth > 600 ? 14 : 12,
      'iconSize': screenWidth > 600 ? 28 : 24,
      'avatarSize': screenWidth > 600 ? 56 : 44,
    };
  }
}