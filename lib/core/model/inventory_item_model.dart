class InventoryItem {
  final String id;
  final String name;
  final String category;
  final double currentStock;
  final String unit;
  final double minStock;
  final double maxStock;
  final double costPrice;
  final double sellingPrice;
  final String supplier;
  final String lastRestocked;
  final String status;
  final String location;
  final String? expiryDate;

  const InventoryItem({
    required this.id,
    required this.name,
    required this.category,
    required this.currentStock,
    required this.unit,
    required this.minStock,
    required this.maxStock,
    required this.costPrice,
    required this.sellingPrice,
    required this.supplier,
    required this.lastRestocked,
    required this.status,
    required this.location,
    this.expiryDate,
  });

  double get totalValue => currentStock * costPrice;
  bool get isLowStock => status.toLowerCase() == 'low stock';
  bool get hasExpiry => expiryDate != null;

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      currentStock: json['currentStock'].toDouble(),
      unit: json['unit'],
      minStock: json['minStock'].toDouble(),
      maxStock: json['maxStock'].toDouble(),
      costPrice: json['costPrice'].toDouble(),
      sellingPrice: json['sellingPrice'].toDouble(),
      supplier: json['supplier'],
      lastRestocked: json['lastRestocked'],
      status: json['status'],
      location: json['location'],
      expiryDate: json['expiryDate'],
    );
  }
}
