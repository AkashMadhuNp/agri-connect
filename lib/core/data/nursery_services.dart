
import 'package:agri/core/model/consultation_model.dart';
import 'package:agri/core/model/service_history.dart';
import 'package:agri/core/model/service_model.dart';
import 'package:flutter/material.dart';

class NurseryDataSource {
  List<ConsultationModel> getTodayConsultations() {
    final consultationMaps = [
      {
        'clientName': 'Rajesh Sharma',
        'farmName': 'Sharma Organic Farm',
        'date': '2024-03-21',
        'time': '10:00 AM',
        'service': 'Soil Analysis',
        'specialist': 'Dr. Sarah Johnson',
        'location': 'Client Farm',
        'phone': '+91-9876543210',
        'status': 'Confirmed',
        'estimatedDuration': '2 hours',
        'fees': 2500,
        'notes': 'Focus on pH levels and nutrient deficiency',
      },
      {
        'clientName': 'Meera Patel',
        'farmName': 'Green Valley Farm',
        'date': '2024-03-21',
        'time': '2:30 PM',
        'service': 'Crop Disease Diagnosis',
        'specialist': 'Dr. Sarah Johnson',
        'location': 'Client Farm',
        'phone': '+91-9876543211',
        'status': 'Pending',
        'estimatedDuration': '1.5 hours',
        'fees': 2000,
        'notes': 'Tomato plants showing yellowing',
      },
    ];

    return consultationMaps
        .where((c) => c['date'] == '2024-03-21')
        .map((c) => ConsultationModel.fromMap(c))
        .toList();
  }

  List<ServiceModel> getAvailableServices() {
    final serviceMaps = [
      {
        'name': 'Soil Analysis & Testing',
        'description': 'Complete soil health assessment including pH, nutrients, and recommendations',
        'price': 2500,
        'duration': '2-3 hours',
        'specialist': 'Dr. Sarah Johnson',
        'icon': Icons.science,
        'category': 'Analysis',
        'includes': ['pH Testing', 'NPK Analysis', 'Micronutrient Check', 'Written Report'],
      },
      {
        'name': 'Crop Disease Diagnosis',
        'description': 'Expert diagnosis and treatment plan for plant diseases',
        'price': 2000,
        'duration': '1-2 hours',
        'specialist': 'Dr. Sarah Johnson',
        'icon': Icons.local_hospital,
        'category': 'Health',
        'includes': ['Visual Inspection', 'Sample Analysis', 'Treatment Plan', 'Follow-up'],
      },
      {
        'name': 'Irrigation System Setup',
        'description': 'Design and installation of efficient irrigation systems',
        'price': 5000,
        'duration': '4-6 hours',
        'specialist': 'Amit Patel',
        'icon': Icons.water_drop,
        'category': 'Infrastructure',
        'includes': ['System Design', 'Installation', 'Testing', '6-month Support'],
      },
    ];

    return serviceMaps.map((s) => ServiceModel.fromMap(s)).toList();
  }

  List<ServiceHistoryModel> getRecentServices() {
    final serviceMaps = [
      {
        'clientName': 'Priya Singh',
        'service': 'Plant Health Check',
        'date': '2024-03-18',
        'fees': 1500,
        'status': 'Completed',
        'rating': 5,
        'payment': 'Paid',
        'followUp': 'Required in 2 weeks',
      },
      {
        'clientName': 'Vikash Gupta',
        'service': 'Pest Control Consultation',
        'date': '2024-03-17',
        'fees': 3000,
        'status': 'Completed',
        'rating': 4,
        'payment': 'Pending',
        'followUp': 'None',
      },
    ];

    return serviceMaps.map((s) => ServiceHistoryModel.fromMap(s)).toList();
  }

  Map<String, dynamic> getServiceStats() {
    return {
      'totalClients': 45,
      'monthlyRevenue': 85000,
      'completedServices': 28,
      'avgRating': 4.6,
      'repeatClients': 32,
      'pendingPayments': 12000,
      'activeServices': 5,
      'avgPrice': 2860,
      'specialists': 3,
    };
  }

  int calculateTodayRevenue(List<ConsultationModel> consultations) {
    return consultations.fold(0, (sum, consultation) => sum + consultation.fees);
  }

  List<Map<String, dynamic>> getPendingPayments() {
    return [
      {
        'clientName': 'Vikash Gupta',
        'service': 'Pest Control',
        'amount': 3000,
        'status': 'Overdue by 3 days',
        'action': 'Remind',
      },
      {
        'clientName': 'Ravi Singh',
        'service': 'Soil Analysis',
        'amount': 2500,
        'status': 'Due today',
        'action': 'Call',
      },
    ];
  }
}
