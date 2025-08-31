

import 'package:agri/core/model/inventory_item_model.dart';
import 'package:agri/core/model/order_item_model.dart';
import 'package:agri/core/model/product_model.dart';

class InventoryRepository {
  static final List<Map<String, dynamic>> _inventoryData = [
    {
      'id': 'INV-001',
      'name': 'Tomato Seeds (Hybrid Cherry)',
      'category': 'Seeds',
      'currentStock': 2.5,
      'unit': 'kg',
      'minStock': 5.0,
      'maxStock': 20.0,
      'costPrice': 800.0,
      'sellingPrice': 1200.0,
      'supplier': 'Premium Seeds Co.',
      'lastRestocked': '2024-02-15',
      'status': 'Low Stock',
      'location': 'Storage-A1',
      'expiryDate': '2025-06-30',
    },
  ];

  static final List<Map<String, dynamic>> _ordersData = [
    {
      'orderId': 'ORD-001',
      'customerName': 'Rajesh Sharma',
      'farmName': 'Sharma Organic Farm',
      'items': [
        {'name': 'Tomato Seedlings', 'quantity': 500, 'price': 15.0, 'total': 7500.0},
        {'name': 'NPK Fertilizer', 'quantity': 2, 'price': 950.0, 'total': 1900.0},
      ],
      'totalAmount': 9400.0,
      'status': 'Delivered',
      'orderDate': '2024-03-18',
      'deliveryDate': '2024-03-20',
      'paymentStatus': 'Paid',
    },
  ];

  static final List<Map<String, dynamic>> _productsData = [
    {
      'name': 'Tomato Seedlings',
      'price': 15.0,
      'unit': 'per plant',
      'available': 2400,
      'sold': 1200,
      'rating': 4.8,
      'category': 'Live Plants',
      'description': 'Healthy hybrid cherry tomato seedlings',
    },
  ];

  List<InventoryItem> getInventoryItems() {
    return _inventoryData.map((data) => InventoryItem.fromJson(data)).toList();
  }

  List<Order> getOrders() {
    return _ordersData.map((data) => Order.fromJson(data)).toList();
  }

  List<Product> getProducts() {
    return _productsData.map((data) => Product.fromJson(data)).toList();
  }

  List<InventoryItem> getLowStockItems() {
    return getInventoryItems().where((item) => item.isLowStock).toList();
  }

  List<Order> getPendingOrders() {
    return getOrders().where((order) => order.isPending).toList();
  }

  double getTotalInventoryValue() {
    return getInventoryItems().fold(0.0, (sum, item) => sum + item.totalValue);
  }

  double getTotalRevenue() {
    return getOrders().fold(0.0, (sum, order) => sum + order.totalAmount);
  }

  int getTotalAvailableProducts() {
    return getProducts().fold(0, (sum, product) => sum + product.available);
  }

  int getTotalSoldProducts() {
    return getProducts().fold(0, (sum, product) => sum + product.sold);
  }

  double getAverageRating() {
    final products = getProducts();
    if (products.isEmpty) return 0.0;
    return products.fold(0.0, (sum, product) => sum + product.rating) / products.length;
  }
}