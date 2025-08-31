class Product {
  final String name;
  final double price;
  final String unit;
  final int available;
  final int sold;
  final double rating;
  final String category;
  final String description;

  const Product({
    required this.name,
    required this.price,
    required this.unit,
    required this.available,
    required this.sold,
    required this.rating,
    required this.category,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: json['price'].toDouble(),
      unit: json['unit'],
      available: json['available'],
      sold: json['sold'],
      rating: json['rating'].toDouble(),
      category: json['category'],
      description: json['description'],
    );
  }
}
