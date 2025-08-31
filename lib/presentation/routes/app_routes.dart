import 'package:agri/presentation/binding/login_binding.dart';
import 'package:agri/presentation/screens/splash_screen.dart';
import 'package:get/get.dart';
import 'package:agri/presentation/screens/login_screen.dart';
import 'package:agri/presentation/screens/signup_screen.dart';
import 'package:agri/presentation/screens/main_screen.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;
  
  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () =>  SplashScreen(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => const SignupScreen(),
    ),
    GetPage(
      name: Routes.MAIN,
      page: () => MainScreen(),
    ),
  ];
}

abstract class Routes {
  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const MAIN = '/main';
}