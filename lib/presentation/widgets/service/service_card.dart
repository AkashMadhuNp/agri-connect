import 'package:agri/core/model/service_model.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/utils/app_strings.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback onEdit;
  final VoidCallback onBook;

  const ServiceCard({
    super.key,
    required this.service,
    required this.onEdit,
    required this.onBook,
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
            _buildDescription(),
            const SizedBox(height: AppDimensions.paddingSmall),
            _buildIncludesSection(),
            const SizedBox(height: AppDimensions.paddingSmall),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppDimensions.paddingSmall),
          decoration: BoxDecoration(
            color: AppColors.primaryGreen.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
          ),
          child: Icon(
            service.icon, 
            color: AppColors.primaryGreen, 
            size: AppDimensions.iconSize,
          ),
        ),
        const SizedBox(width: AppDimensions.paddingMedium),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                service.name, 
                style: const TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                service.specialist, 
                style: const TextStyle(
                  color: AppColors.primaryGreen, 
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Rs. ${service.price}', 
              style: const TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold, 
                color: AppColors.primaryGreen,
              ),
            ),
            Text(
              service.duration, 
              style: const TextStyle(
                fontSize: 11, 
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      service.description, 
      style: const TextStyle(
        fontSize: 14, 
        color: AppColors.textSecondary,
      ),
    );
  }

  Widget _buildIncludesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Includes:', 
          style: TextStyle(
            fontSize: 12, 
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingTiny),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: service.includes.map<Widget>((item) => Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingTiny, 
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
            ),
            child: Text(
              item, 
              style: const TextStyle(
                fontSize: 10, 
                color: AppColors.primaryGreen,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onEdit,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryGreen,
            ),
            child: const Text('Edit Service'),
          ),
        ),
        const SizedBox(width: AppDimensions.paddingTiny),
        Expanded(
          child: ElevatedButton(
            onPressed: onBook,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              foregroundColor: AppColors.textWhite,
            ),
            child: const Text('Book Now'),
          ),
        ),
      ],
    );
  }
}
