import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agri/core/service/firebase_auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  _checkAuthAndNavigate() async {
    print('Starting splash screen...');
    
    await Future.delayed(const Duration(seconds: 3));
    
    if (mounted) {
      try {
        final currentUser = FirebaseAuthService.currentUser;
        
        if (currentUser != null) {
          if (currentUser.emailVerified) {
            print('User is logged in and email verified, navigating to main screen...');
            Get.offNamed('/main'); 
          } else {
            
            print('User logged in but email not verified, navigating to main screen...');
            Get.offNamed('/main'); 
          }
        } else {
          
          print('No user logged in, navigating to login screen...');
          Get.offNamed('/login');
        }
        
        print('Navigation call completed');
      } catch (e) {
        print('Error checking auth state: $e');
        
        Get.offNamed('/login');
      }
    }
  }

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
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.agriculture,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                'Agri App',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Your Agricultural Companion',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 50),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}