import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/model/staff_model.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/app_strings.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:agri/presentation/widgets/monitor/app_error.dart';
import 'package:agri/presentation/widgets/monitor/base_card.dart';
import 'package:agri/presentation/widgets/monitor/loading_widget.dart';
import 'package:agri/presentation/widgets/monitor/staff_card.dart';
import 'package:agri/presentation/widgets/monitor/staff_stat_widget.dart';
import 'package:flutter/material.dart';

class StaffTab extends StatelessWidget {
  final List<StaffMember> staffMembers;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback onRefresh;

  const StaffTab({
    super.key,
    required this.staffMembers,
    required this.isLoading,
    this.errorMessage,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const LoadingWidget(message: AppStrings.loadingStaffData);
    }

    if (errorMessage != null) {
      return AppErrorWidget(
        message: AppStrings.errorLoadingData,
        description: errorMessage,
        onRetry: onRefresh,
      );
    }

    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Staff Overview Card
            BaseCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.todaysWorkStatus, style: AppTextStyles.heading3),
                  const SizedBox(height: AppDimensions.paddingSmall),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      StaffStatWidget(
                        label: AppStrings.onDuty,
                        value: '${staffMembers.where((s) => s.status == 'On Duty').length}',
                        color: AppColors.success,
                      ),
                      StaffStatWidget(
                        label: AppStrings.available,
                        value: '${staffMembers.where((s) => s.status == 'Available').length}',
                        color: AppColors.info,
                      ),
                      StaffStatWidget(
                        label: AppStrings.totalTasks,
                        value: '${_getTotalTasks()}',
                        color: AppColors.warning,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.paddingLarge),

            // Staff List Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppStrings.staffAssignments, style: AppTextStyles.heading3),
                IconButton(
                  onPressed: onRefresh,
                  icon: const Icon(Icons.refresh, color: AppColors.primaryGreen),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingSmall),

            // Staff List
            if (staffMembers.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppDimensions.paddingXLarge),
                  child: Text('No staff members found', style: AppTextStyles.body2),
                ),
              )
            else
              ...staffMembers.map((staff) => StaffCardWidget(
                    staff: staff,
                    onCallPressed: () => _callStaff(context, staff),
                    onAssignTaskPressed: () => _assignTask(context, staff),
                  )),
          ],
        ),
      ),
    );
  }

  int _getTotalTasks() {
    return staffMembers.isEmpty 
        ? 0 
        : staffMembers.map((s) => s.todaysTasks).reduce((a, b) => a + b);
  }

  void _callStaff(BuildContext context, StaffMember staff) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Call ${staff.name}'),
        content: Text('Would you like to call ${staff.name} at ${staff.phone}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Calling ${staff.name}...')),
              );
            },
            child: const Text(AppStrings.call),
          ),
        ],
      ),
    );
  }

  void _assignTask(BuildContext context, StaffMember staff) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Assign Task to ${staff.name}'),
        content: const Text('This would open a form to assign a new task.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Assign'),
          ),
        ],
      ),
    );
  }
}
