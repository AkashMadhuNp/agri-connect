import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/app_strings.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:agri/presentation/widgets/monitor/primary_button.dart';
import 'package:agri/presentation/widgets/monitor/secondary_button.dart';
import 'package:flutter/material.dart';

class AddBatchDialog extends StatefulWidget {
  const AddBatchDialog({super.key});

  @override
  State<AddBatchDialog> createState() => _AddBatchDialogState();
}

class _AddBatchDialogState extends State<AddBatchDialog> {
  final _formKey = GlobalKey<FormState>();
  final _cropController = TextEditingController();
  final _varietyController = TextEditingController();
  final _quantityController = TextEditingController();
  final _locationController = TextEditingController();
  
  String? _selectedCropType;
  bool _isSubmitting = false;
  
  final List<String> _cropTypes = [
    'Tomato',
    'Pepper',
    'Lettuce',
    'Cucumber',
    'Herbs',
    'Other',
  ];

  @override
  void dispose() {
    _cropController.dispose();
    _varietyController.dispose();
    _quantityController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text('Add New Production Batch', style: AppTextStyles.heading3),
            const SizedBox(height: AppDimensions.paddingMedium),
            
            // Form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Crop Type Dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedCropType,
                    decoration: _buildInputDecoration('Crop Type'),
                    items: _cropTypes.map((crop) => DropdownMenuItem(
                      value: crop,
                      child: Text(crop),
                    )).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCropType = value;
                      });
                    },
                    validator: (value) => value == null ? 'Please select crop type' : null,
                  ),
                  const SizedBox(height: AppDimensions.paddingMedium),
                  
                  // Variety
                  TextFormField(
                    controller: _varietyController,
                    decoration: _buildInputDecoration('Variety'),
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter variety' : null,
                  ),
                  const SizedBox(height: AppDimensions.paddingMedium),
                  
                  // Quantity
                  TextFormField(
                    controller: _quantityController,
                    decoration: _buildInputDecoration('Quantity'),
                    keyboardType: TextInputType.number,
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter quantity' : null,
                  ),
                  const SizedBox(height: AppDimensions.paddingMedium),
                  
                  // Location
                  TextFormField(
                    controller: _locationController,
                    decoration: _buildInputDecoration('Location'),
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter location' : null,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: AppDimensions.paddingLarge),
            
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SecondaryButton(
                  text: AppStrings.cancel,
                  onPressed: _isSubmitting ? null : () => Navigator.pop(context),
                ),
                const SizedBox(width: AppDimensions.paddingMedium),
                PrimaryButton(
                  text: AppStrings.add,
                  isLoading: _isSubmitting,
                  onPressed: _handleSubmit,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
        borderSide: const BorderSide(color: AppColors.primaryGreen),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _isSubmitting = true;
    });
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Production batch added successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error adding batch: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }
}
