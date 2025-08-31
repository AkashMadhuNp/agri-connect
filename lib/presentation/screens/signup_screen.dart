
import 'package:agri/presentation/controllers/signup_controllers.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:agri/presentation/widgets/applogo_title.dart';
import 'package:agri/presentation/widgets/custom_auth_button.dart';
import 'package:agri/presentation/widgets/custom_text_field.dart';

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF55DC9B),
              Color(0xFF4CAF50),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  
                  // Back Button
                  GestureDetector(
                    onTap: controller.navigateBackToLogin,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // App Logo and Title
                  AppLogoTitle(),
                  
                  const SizedBox(height: 30),
                  
                  // Signup Form Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D5016),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Fill in your details to get started',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        
                        const SizedBox(height: 32),
                        
                        // Farm Name Field
                        CustomTextField(
                          label: 'Farm Name',
                          hint: 'Enter your Farm name',
                          prefixIcon: Icons.person_outline,
                          controller: controller.nameController,
                          validator: controller.validateName,
                          keyboardType: TextInputType.name,
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Email Field
                        CustomTextField(
                          label: 'Email Address',
                          hint: 'Enter your email',
                          prefixIcon: Icons.email_outlined,
                          controller: controller.emailController,
                          validator: controller.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Phone Field
                        CustomTextField(
                          label: 'Phone Number',
                          hint: 'Enter your phone number',
                          prefixIcon: Icons.phone_outlined,
                          controller: controller.phoneController,
                          validator: controller.validatePhoneNumber,
                          keyboardType: TextInputType.phone,
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Location Field with Current Location Button
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => CustomTextField(
                              label: 'Location',
                              hint: 'Enter your location or tap to fetch current location',
                              prefixIcon: Icons.location_on_outlined,
                              controller: controller.locationController,
                              validator: controller.validateLocation,
                              keyboardType: TextInputType.streetAddress,
                              readOnly: controller.isFetchingLocation,
                            )),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: Obx(() => ElevatedButton.icon(
                                onPressed: controller.isFetchingLocation 
                                    ? null 
                                    : controller.getCurrentLocation,
                                icon: controller.isFetchingLocation
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            Colors.white,
                                          ),
                                        ),
                                      )
                                    : const Icon(Icons.my_location, size: 18),
                                label: Text(
                                  controller.isFetchingLocation 
                                      ? 'Fetching Location...' 
                                      : 'Use Current Location',
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF55DC9B),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 0,
                                ),
                              )),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Password Field
                        Obx(() => CustomTextField(
                          label: 'Password',
                          hint: 'Enter your password',
                          prefixIcon: Icons.lock_outline,
                          controller: controller.passwordController,
                          validator: controller.validatePassword,
                          isPassword: true,
                          obscureText: controller.obscurePassword,
                          onToggleVisibility: controller.togglePasswordVisibility,
                        )),
                        
                        const SizedBox(height: 20),
                        
                        // Confirm Password Field
                        Obx(() => CustomTextField(
                          label: 'Confirm Password',
                          hint: 'Confirm your password',
                          prefixIcon: Icons.lock_outline,
                          controller: controller.confirmPasswordController,
                          validator: controller.validateConfirmPassword,
                          isPassword: true,
                          obscureText: controller.obscureConfirmPassword,
                          onToggleVisibility: controller.toggleConfirmPasswordVisibility,
                        )),
                        
                        const SizedBox(height: 20),
                        
                        // Terms and Conditions Checkbox
                        Row(
                          children: [
                            Obx(() => Checkbox(
                              value: controller.agreeToTerms,
                              onChanged: controller.toggleTermsAgreement,
                              activeColor: const Color(0xFF55DC9B),
                            )),
                            Expanded(
                              child: Text(
                                'I agree to the Terms and Conditions',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Signup Button
                        Obx(() => CustomButton(
                          text: 'Create Account',
                          onPressed: controller.handleSignup,
                          isLoading: controller.isLoading,
                        )),
                        
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Sign In Link
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          onPressed: controller.navigateBackToLogin,
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}