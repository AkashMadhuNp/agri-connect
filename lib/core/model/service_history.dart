class ServiceHistoryModel {
  final String clientName;
  final String service;
  final String date;
  final int fees;
  final String status;
  final int? rating;
  final String payment;
  final String followUp;

  const ServiceHistoryModel({
    required this.clientName,
    required this.service,
    required this.date,
    required this.fees,
    required this.status,
    this.rating,
    required this.payment,
    required this.followUp,
  });

  factory ServiceHistoryModel.fromMap(Map<String, dynamic> map) {
    return ServiceHistoryModel(
      clientName: map['clientName'] ?? '',
      service: map['service'] ?? '',
      date: map['date'] ?? '',
      fees: map['fees'] ?? 0,
      status: map['status'] ?? '',
      rating: map['rating'],
      payment: map['payment'] ?? '',
      followUp: map['followUp'] ?? '',
    );
  }
}

