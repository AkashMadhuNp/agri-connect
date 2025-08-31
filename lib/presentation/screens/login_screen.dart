import 'package:agri/presentation/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:agri/presentation/widgets/applogo_title.dart';
import 'package:agri/presentation/widgets/custom_auth_button.dart';
import 'package:agri/presentation/widgets/custom_text_field.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

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
                  const SizedBox(height: 40),
                  
                  // App Logo and Title
                  AppLogoTitle(),
                  
                  const SizedBox(height: 40),
                  
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
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D5016),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Sign in to continue to your account',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        
                        const SizedBox(height: 32),
                        
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
                        
                        const SizedBox(height: 16),
                        
                        // Remember Me and Forgot Password Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Obx(() => Checkbox(
                                    value: controller.rememberMe,
                                    onChanged: controller.toggleRememberMe,
                                    activeColor: const Color(0xFF55DC9B),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  )),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Remember me',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF2D5016),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: controller.handleForgotPassword,
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF55DC9B),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Login Button
                        Obx(() => CustomButton(
                          text: 'Sign In',
                          onPressed: controller.handleLogin,
                          isLoading: controller.isLoading,
                        )),
                        
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Sign Up Link
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          onPressed: controller.navigateToSignup,
                          child: const Text(
                            'Sign Up',
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