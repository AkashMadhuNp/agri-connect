import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:agri/core/model/production_batch_model.dart';

class ProductionBatchService {
  static const String _baseUrl = 'https://68b2cba7c28940c9e69d679c.mockapi.io/production';
  static const String _endpoint = 'productionbatch';

  static Future<List<ProductionBatch>> fetchProductionBatches() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/$_endpoint'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => ProductionBatch.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load production batches: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching production batches: $e');
    }
  }

  static Future<ProductionBatch?> fetchProductionBatchById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/$_endpoint/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return ProductionBatch.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw Exception('Failed to load production batch: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching production batch: $e');
    }
  }

  static Future<ProductionBatch> createProductionBatch(ProductionBatch batch) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/$_endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(batch.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return ProductionBatch.fromJson(jsonData);
      } else {
        throw Exception('Failed to create production batch: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating production batch: $e');
    }
  }

  static Future<ProductionBatch> updateProductionBatch(String id, ProductionBatch batch) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/$_endpoint/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(batch.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return ProductionBatch.fromJson(jsonData);
      } else {
        throw Exception('Failed to update production batch: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating production batch: $e');
    }
  }

  static Future<bool> deleteProductionBatch(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/$_endpoint/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      throw Exception('Error deleting production batch: $e');
    }
  }

  static Future<List<ProductionBatch>> fetchProductionBatchesByStatus(String status) async {
    final allBatches = await fetchProductionBatches();
    return allBatches.where((batch) => batch.status.toLowerCase() == status.toLowerCase()).toList();
  }

  static Future<List<ProductionBatch>> fetchActiveProductionBatches() async {
    final allBatches = await fetchProductionBatches();
    return allBatches.where((batch) => batch.isActive).toList();
  }

  static Future<List<ProductionBatch>> fetchCompletedProductionBatches() async {
    final allBatches = await fetchProductionBatches();
    return allBatches.where((batch) => batch.isCompleted).toList();
  }

  static Future<List<ProductionBatch>> fetchBatchesNeedingAttention() async {
    final allBatches = await fetchProductionBatches();
    return allBatches.where((batch) => batch.needsAttention).toList();
  }

  static Future<List<ProductionBatch>> fetchReadyToHarvestBatches() async {
    final allBatches = await fetchProductionBatches();
    return allBatches.where((batch) => batch.isReady).toList();
  }
}