

import 'package:agri/core/model/userdatamodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static User? get currentUser => _auth.currentUser;

  static Stream<User?> get userStream => _auth.authStateChanges();

  static Future<AuthResult> signUpWithEmailPassword({
    required String name,
    required String email,
    required String phone,
    required String location,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(name);

        final userData = UserData(
          uid: userCredential.user!.uid,
          name: name.trim(),
          email: email.trim().toLowerCase(),
          phone: phone.trim(),
          location: location.trim(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(userData.toMap());

        await userCredential.user!.sendEmailVerification();

        return AuthResult(
          success: true,
          message: 'Account created successfully! Please verify your email.',
          user: userCredential.user,
        );
      } else {
        return AuthResult(
          success: false,
          message: 'Failed to create account. Please try again.',
          error: 'User creation failed',
        );
      }
    } on FirebaseAuthException catch (e) {
      return AuthResult(
        success: false,
        message: _getAuthErrorMessage(e.code),
        error: e.code,
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message: 'An unexpected error occurred. Please try again.',
        error: e.toString(),
      );
    }
  }

  static Future<AuthResult> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (userCredential.user != null) {
        return AuthResult(
          success: true,
          message: 'Login successful!',
          user: userCredential.user,
        );
      } else {
        return AuthResult(
          success: false,
          message: 'Login failed. Please try again.',
          error: 'Sign in failed',
        );
      }
    } on FirebaseAuthException catch (e) {
      return AuthResult(
        success: false,
        message: _getAuthErrorMessage(e.code),
        error: e.code,
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message: 'An unexpected error occurred. Please try again.',
        error: e.toString(),
      );
    }
  }

  static Future<AuthResult> signOut() async {
    try {
      await _auth.signOut();
      
      return AuthResult(
        success: true,
        message: 'Signed out successfully!',
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message: 'Failed to sign out. Please try again.',
        error: e.toString(),
      );
    }
  }

  

  static Future<UserData?> getUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserData.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<AuthResult> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return AuthResult(
          success: false,
          message: 'No user is currently signed in.',
          error: 'No current user',
        );
      }

      await _firestore.collection('users').doc(user.uid).delete();

      await user.delete();

      return AuthResult(
        success: true,
        message: 'Account deleted successfully!',
      );
    } on FirebaseAuthException catch (e) {
      return AuthResult(
        success: false,
        message: _getAuthErrorMessage(e.code),
        error: e.code,
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message: 'Failed to delete account. Please try again.',
        error: e.toString(),
      );
    }
  }

  
  static String _getAuthErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No account found with this email address.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later.';
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case 'invalid-credential':
        return 'The provided credentials are invalid.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with a different sign-in method.';
      case 'requires-recent-login':
        return 'Please sign in again to complete this action.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support.';
      case 'invalid-verification-code':
        return 'The verification code is invalid.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}