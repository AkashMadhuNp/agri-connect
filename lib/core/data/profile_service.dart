import 'package:agri/core/data/profile_repository.dart';
import 'package:agri/core/model/userdatamodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  final ProfileRepository _repository = ProfileRepository();

  Future<UserData?> getUserData(String uid) async {
    return await _repository.getUserData(uid);
  }

  Future<bool> updateUserData(String uid, UserData userData) async {
    return await _repository.updateUserData(uid, userData);
  }

  Future<bool> signOut() async {
    return await _repository.signOut();
  }

  User? getCurrentUser() {
    return _repository.getCurrentUser();
  }
}
