import 'package:agri/presentation/controllers/signup_controllers.dart';
import 'package:agri/presentation/screens/signup_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agri/core/service/firebase_auth_service.dart';
import 'package:agri/core/utils/validators.dart';
import 'package:agri/presentation/screens/main_screen.dart';

class LoginController extends GetxController {
  // Form key
  final formKey = GlobalKey<FormState>();
  
  // Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  // Observable variables
  final _obscurePassword = true.obs;
  final _isLoading = false.obs;
  final _rememberMe = false.obs;
  
  // Getters for reactive variables
  bool get obscurePassword => _obscurePassword.value;
  bool get isLoading => _isLoading.value;
  bool get rememberMe => _rememberMe.value;
  
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
  
  // Toggle password visibility
  void togglePasswordVisibility() {
    _obscurePassword.toggle();
  }
  
  // Toggle remember me
  void toggleRememberMe(bool? value) {
    _rememberMe.value = value ?? false;
  }
  
  // Show error snackbar
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
  
  // Show success snackbar
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
  
  // Handle login
  Future<void> handleLogin() async {
    if (!formKey.currentState!.validate()) return;
    
    try {
      _isLoading.value = true;
      
      final result = await FirebaseAuthService.signInWithEmailPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      
      if (result.success) {
        _showSuccessSnackBar(result.message);
        
        await Future.delayed(const Duration(seconds: 1));
        Get.off(() => MainScreen());
        
        
      } else {
        _showErrorSnackBar(result.message);
      }
    } catch (e) {
      _showErrorSnackBar('An unexpected error occurred. Please try again.');
    } finally {
      _isLoading.value = false;
    }
  }
  
  Future<void> handleForgotPassword() async {
    if (emailController.text.trim().isEmpty) {
      _showErrorSnackBar('Please enter your email address first');
      return;
    }
    
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      
      _showSuccessSnackBar('Password reset email sent! Check your inbox.');
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No account found with this email address.';
          break;
        case 'invalid-email':
          message = 'Invalid email address.';
          break;
        default:
          message = 'Failed to send reset email. Please try again.';
      }
      _showErrorSnackBar(message);
    } catch (e) {
      _showErrorSnackBar('An error occurred. Please try again.');
    }
  }
  
  void navigateToSignup() {
  Get.lazyPut(() => SignupController());
  Get.to(() => const SignupScreen());
}
  
  // Email validator
  String? validateEmail(String? value) {
    return ValidationUtils.validateEmail(value);
  }
  
  // Password validator
  String? validatePassword(String? value) {
    return ValidationUtils.validatePassword(value);
  }
}