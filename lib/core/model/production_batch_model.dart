class ProductionBatch {
  final String id;
  final String crop;
  final String variety;
  final int quantity;
  final String planted;
  final String expectedHarvest;
  final String currentStage;
  final int progress;
  final int health;
  final String location;
  final String image;
  final String status;
  final int daysRemaining;
  final int estimatedYield;
  final String wateringSchedule;
  final String lastInspection;
  final List<String> issues;

  ProductionBatch({
    required this.id,
    required this.crop,
    required this.variety,
    required this.quantity,
    required this.planted,
    required this.expectedHarvest,
    required this.currentStage,
    required this.progress,
    required this.health,
    required this.location,
    required this.image,
    required this.status,
    required this.daysRemaining,
    required this.estimatedYield,
    required this.wateringSchedule,
    required this.lastInspection,
    required this.issues,
  });

  factory ProductionBatch.fromJson(Map<String, dynamic> json) {
    return ProductionBatch(
      id: json['id'] ?? '',
      crop: json['crop'] ?? '',
      variety: json['variety'] ?? '',
      quantity: json['quantity'] ?? 0,
      planted: json['planted'] ?? '',
      expectedHarvest: json['expectedHarvest'] ?? '',
      currentStage: json['currentStage'] ?? '',
      progress: json['progress'] ?? 0,
      health: json['health'] ?? 0,
      location: json['location'] ?? '',
      image: json['image'] ?? '',
      status: json['status'] ?? '',
      daysRemaining: json['daysRemaining'] ?? 0,
      estimatedYield: json['estimatedYield'] ?? 0,
      wateringSchedule: json['wateringSchedule'] ?? '',
      lastInspection: json['lastInspection'] ?? '',
      issues: List<String>.from(json['issues'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'crop': crop,
      'variety': variety,
      'quantity': quantity,
      'planted': planted,
      'expectedHarvest': expectedHarvest,
      'currentStage': currentStage,
      'progress': progress,
      'health': health,
      'location': location,
      'image': image,
      'status': status,
      'daysRemaining': daysRemaining,
      'estimatedYield': estimatedYield,
      'wateringSchedule': wateringSchedule,
      'lastInspection': lastInspection,
      'issues': issues,
    };
  }

  bool get isActive => status != 'Completed';
  bool get isCompleted => status == 'Completed';
  bool get needsAttention => status == 'Needs Attention';
  bool get isReady => status == 'Ready';
  bool get hasIssues => issues.isNotEmpty;
}