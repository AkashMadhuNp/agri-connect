

class StaffMember {
  final String name;
  final String role;
  final String avatar;
  final String currentTask;
  final List<String> assignedSections;
  final List<String> expertise;
  final String status;
  final String phone;
  final int todaysTasks;
  final int completedTasks;

  StaffMember({
    required this.name,
    required this.role,
    required this.avatar,
    required this.currentTask,
    required this.assignedSections,
    required this.expertise,
    required this.status,
    required this.phone,
    required this.todaysTasks,
    required this.completedTasks,
  });

  factory StaffMember.fromJson(Map<String, dynamic> json) {
    return StaffMember(
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      avatar: json['avatar'] ?? '👤',
      currentTask: json['currentTask'] ?? '',
      assignedSections: List<String>.from(json['assignedSections'] ?? []),
      expertise: List<String>.from(json['expertise'] ?? []),
      status: json['status'] ?? '',
      phone: json['phone'] ?? '',
      todaysTasks: json['todaysTasks'] ?? 0,
      completedTasks: json['completedTasks'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
      'avatar': avatar,
      'currentTask': currentTask,
      'assignedSections': assignedSections,
      'expertise': expertise,
      'status': status,
      'phone': phone,
      'todaysTasks': todaysTasks,
      'completedTasks': completedTasks,
    };
  }
}