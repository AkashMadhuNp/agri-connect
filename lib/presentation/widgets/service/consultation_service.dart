import 'package:agri/core/model/consultation_model.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/nursey_service_ytils.dart';
import 'package:flutter/material.dart';
import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/utils/app_strings.dart';

class ConsultationCard extends StatelessWidget {
  final ConsultationModel consultation;
  final VoidCallback onCall;
  final VoidCallback onNavigate;

  const ConsultationCard({
    super.key,
    required this.consultation,
    required this.onCall,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingSmall),
      elevation: AppDimensions.cardElevation,
      color: AppColors.cardBackground,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: AppDimensions.paddingSmall),
            _buildTimeAndSpecialist(),
            const SizedBox(height: AppDimensions.paddingTiny),
            _buildServiceAndFees(),
            if (consultation.notes.isNotEmpty) ...[
              const SizedBox(height: AppDimensions.paddingTiny),
              _buildNotesSection(),
            ],
            const SizedBox(height: AppDimensions.paddingSmall),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                consultation.clientName,
                style: const TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                consultation.farmName, 
                style: const TextStyle(color: AppColors.primaryGreen),
              ),
            ],
          ),
        ),
        Chip(
          label: Text(
            consultation.status, 
            style: const TextStyle(fontSize: 10),
          ),
          backgroundColor: StatusUtils.getConsultationStatusColor(consultation.status)
              .withOpacity(0.2),
        ),
      ],
    );
  }

  Widget _buildTimeAndSpecialist() {
    return Row(
      children: [
        Icon(Icons.access_time, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: AppDimensions.paddingTiny),
        Expanded(
          child: Text(
            consultation.specialist, 
            style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceAndFees() {
    return Row(
      children: [
        Icon(Icons.build, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: AppDimensions.paddingTiny),
        Text(
          consultation.service, 
          style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        const Spacer(),
        Text(
          'Rs. ${consultation.fees}', 
          style: const TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.bold, 
            color: AppColors.primaryGreen,
          ),
        ),
      ],
    );
  }

  Widget _buildNotesSection() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingTiny),
      decoration: BoxDecoration(
        color: AppColors.info.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.note, size: 16, color: AppColors.info),
          const SizedBox(width: AppDimensions.paddingTiny),
          Expanded(
            child: Text(
              consultation.notes, 
              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onCall,
            icon: const Icon(Icons.call, size: 16),
            label: const Text(AppStrings.call, style: TextStyle(fontSize: 12)),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryGreen,
            ),
          ),
        ),
        const SizedBox(width: AppDimensions.paddingTiny),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onNavigate,
            icon: const Icon(Icons.directions, size: 16),
            label: const Text('Navigate', style: TextStyle(fontSize: 12)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              foregroundColor: AppColors.textWhite,
            ),
          ),
        ),
      ],
    );
  }
}
