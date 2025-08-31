import 'package:flutter/material.dart';

class ServiceModel {
  final String name;
  final String description;
  final int price;
  final String duration;
  final String specialist;
  final IconData icon;
  final String category;
  final List<String> includes;

  const ServiceModel({
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    required this.specialist,
    required this.icon,
    required this.category,
    required this.includes,
  });

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? 0,
      duration: map['duration'] ?? '',
      specialist: map['specialist'] ?? '',
      icon: map['icon'] ?? Icons.help,
      category: map['category'] ?? '',
      includes: List<String>.from(map['includes'] ?? []),
    );
  }
}
