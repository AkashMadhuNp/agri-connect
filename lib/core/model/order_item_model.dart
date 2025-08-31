class OrderItem {
  final String name;
  final int quantity;
  final double price;
  final double total;

  const OrderItem({
    required this.name,
    required this.quantity,
    required this.price,
    required this.total,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      total: json['total'].toDouble(),
    );
  }
}

class Order {
  final String orderId;
  final String customerName;
  final String farmName;
  final List<OrderItem> items;
  final double totalAmount;
  final String status;
  final String orderDate;
  final String deliveryDate;
  final String paymentStatus;

  const Order({
    required this.orderId,
    required this.customerName,
    required this.farmName,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.orderDate,
    required this.deliveryDate,
    required this.paymentStatus,
  });

  bool get isPending => status.toLowerCase() != 'delivered';
  bool get isPaid => paymentStatus.toLowerCase() == 'paid';

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'],
      customerName: json['customerName'],
      farmName: json['farmName'],
      items: (json['items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      totalAmount: json['totalAmount'].toDouble(),
      status: json['status'],
      orderDate: json['orderDate'],
      deliveryDate: json['deliveryDate'],
      paymentStatus: json['paymentStatus'],
    );
  }
}
