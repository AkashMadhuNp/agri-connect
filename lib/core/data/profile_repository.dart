import 'package:agri/core/model/userdatamodel.dart';
import 'package:agri/core/service/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepository {
  Future<UserData?> getUserData(String uid) async {
    try {
      return await FirebaseAuthService.getUserData(uid);
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateUserData(String uid, UserData userData) async {
    try {
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      final result = await FirebaseAuthService.signOut();
      return result.success;
    } catch (e) {
      return false;
    }
  }

  User? getCurrentUser() {
    return FirebaseAuthService.currentUser;
  }
}
