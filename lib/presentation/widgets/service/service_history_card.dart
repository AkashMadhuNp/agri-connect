import 'package:agri/core/model/service_history.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/nursey_service_ytils.dart';
import 'package:flutter/material.dart';
import 'package:agri/core/colors/colors.dart';

class ServiceHistoryCard extends StatelessWidget {
  final ServiceHistoryModel service;

  const ServiceHistoryCard({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingTiny),
      elevation: AppDimensions.cardElevation,
      color: AppColors.cardBackground,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: StatusUtils.getServiceStatusColor(service.status)
              .withOpacity(0.2),
          child: Icon(
            StatusUtils.getServiceStatusIcon(service.status),
            color: StatusUtils.getServiceStatusColor(service.status),
            size: AppDimensions.iconSizeSmall,
          ),
        ),
        title: Text(
          '${service.clientName} - ${service.service}',
          style: const TextStyle(color: AppColors.textPrimary),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${service.date} • Rs. ${service.fees} • ${service.payment}',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            if (service.followUp != 'None')
              Text(
                'Follow-up: ${service.followUp}', 
                style: const TextStyle(
                  color: AppColors.warning, 
                  fontSize: 11,
                ),
              ),
          ],
        ),
        trailing: service.rating != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star, 
                    size: AppDimensions.iconSizeSmall, 
                    color: AppColors.warning,
                  ),
                  Text(
                    '${service.rating}',
                    style: const TextStyle(color: AppColors.textPrimary),
                  ),
                ],
              )
            : const Text(
                'Pending', 
                style: TextStyle(color: AppColors.warning),
              ),
      ),
    );
  }
}
