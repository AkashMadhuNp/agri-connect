class ConsultationModel {
  final String clientName;
  final String farmName;
  final String date;
  final String time;
  final String service;
  final String specialist;
  final String location;
  final String phone;
  final String status;
  final String estimatedDuration;
  final int fees;
  final String notes;

  const ConsultationModel({
    required this.clientName,
    required this.farmName,
    required this.date,
    required this.time,
    required this.service,
    required this.specialist,
    required this.location,
    required this.phone,
    required this.status,
    required this.estimatedDuration,
    required this.fees,
    required this.notes,
  });

  factory ConsultationModel.fromMap(Map<String, dynamic> map) {
    return ConsultationModel(
      clientName: map['clientName'] ?? '',
      farmName: map['farmName'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      service: map['service'] ?? '',
      specialist: map['specialist'] ?? '',
      location: map['location'] ?? '',
      phone: map['phone'] ?? '',
      status: map['status'] ?? '',
      estimatedDuration: map['estimatedDuration'] ?? '',
      fees: map['fees'] ?? 0,
      notes: map['notes'] ?? '',
    );
  }
}
