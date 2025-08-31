
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:agri/core/service/firebase_auth_service.dart';
import 'package:agri/core/utils/validators.dart';

class SignupController extends GetxController {
  // Form key
  final formKey = GlobalKey<FormState>();
  
  // Text controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  
  // Observable variables
  final _obscurePassword = true.obs;
  final _obscureConfirmPassword = true.obs;
  final _isLoading = false.obs;
  final _agreeToTerms = false.obs;
  final _isFetchingLocation = false.obs;
  
  bool get obscurePassword => _obscurePassword.value;
  bool get obscureConfirmPassword => _obscureConfirmPassword.value;
  bool get isLoading => _isLoading.value;
  bool get agreeToTerms => _agreeToTerms.value;
  bool get isFetchingLocation => _isFetchingLocation.value;
  
  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
  
  // Toggle password visibility
  void togglePasswordVisibility() {
    _obscurePassword.toggle();
  }
  
  // Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword.toggle();
  }
  
  void toggleTermsAgreement(bool? value) {
    _agreeToTerms.value = value ?? false;
  }
  
  void _showErrorSnackBar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }
  
  void _showSuccessSnackBar(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF55DC9B),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 2),
    );
  }
  
  Future<void> getCurrentLocation() async {
    _isFetchingLocation.value = true;

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showErrorSnackBar('Location services are disabled. Please enable location services.');
        _isFetchingLocation.value = false;
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showErrorSnackBar('Location permissions are denied');
          _isFetchingLocation.value = false;
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showErrorSnackBar('Location permissions are permanently denied, we cannot request permissions.');
        _isFetchingLocation.value = false;
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      String locationText = '${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}';
      
      locationController.text = locationText;
      _isFetchingLocation.value = false;

      _showSuccessSnackBar('Location fetched successfully!');
    } catch (e) {
      _isFetchingLocation.value = false;
      _showErrorSnackBar('Failed to get location: ${e.toString()}');
    }
  }
  
  Future<void> handleSignup() async {
    if (!_agreeToTerms.value) {
      _showErrorSnackBar('Please agree to the terms and conditions');
      return;
    }

    if (!formKey.currentState!.validate()) return;
    
    try {
      _isLoading.value = true;
      
      final result = await FirebaseAuthService.signUpWithEmailPassword(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        location: locationController.text.trim(),
        password: passwordController.text,
      );
      
      if (result.success) {
        _showSuccessSnackBar(result.message);
        
        await Future.delayed(const Duration(seconds: 2));
        Get.back();
      } else {
        _showErrorSnackBar(result.message);
      }
    } catch (e) {
      _showErrorSnackBar('An unexpected error occurred. Please try again.');
    } finally {
      _isLoading.value = false;
    }
  }
  
  void navigateBackToLogin() {
    Get.back();
  }
  
  String? validateName(String? value) {
    return ValidationUtils.validateName(value);
  }
  
  String? validateEmail(String? value) {
    return ValidationUtils.validateEmail(value);
  }
  
  String? validatePhoneNumber(String? value) {
    return ValidationUtils.validatePhoneNumber(value);
  }
  
  String? validateLocation(String? value) {
    return ValidationUtils.validateLocation(value);
  }
  
  String? validatePassword(String? value) {
    return ValidationUtils.validatePassword(value);
  }
  
  String? validateConfirmPassword(String? value) {
    return ValidationUtils.validateConfirmPassword(value, passwordController.text);
  }
}