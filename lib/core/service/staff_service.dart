

import 'dart:convert';

import 'package:agri/core/model/staff_model.dart';
import 'package:http/http.dart' as http;

class StaffService {
  static const String baseUrl = 'https://68b1df37a860fe41fd5fd49d.mockapi.io/cropmonitor';
  
  static Future<List<StaffMember>> fetchStaff() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/staffs'));
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        print(response.body);
        return jsonData.map((json) => StaffMember.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load staff data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching staff data: $e');
    }
  }

  static Future<StaffMember> addStaff(StaffMember staff) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/staffs'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(staff.toJson()),
      );
      
      if (response.statusCode == 201) {
        return StaffMember.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to add staff member');
      }
    } catch (e) {
      throw Exception('Error adding staff member: $e');
    }
  }

  static Future<StaffMember> updateStaff(String id, StaffMember staff) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/staffs/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(staff.toJson()),
      );
      
      if (response.statusCode == 200) {
        return StaffMember.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update staff member');
      }
    } catch (e) {
      throw Exception('Error updating staff member: $e');
    }
  }
}