import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../models/user.dart';
import '../utils/helpers.dart';

class AuthService extends GetxService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final firebase_auth.FirebaseAuth _firebaseAuth =
      firebase_auth.FirebaseAuth.instance;
  final Rx<User?> _user = Rx<User?>(null);
  final RxBool _isInitialized = false.obs;

  User? get user => _user.value;
  bool get isLoggedIn => _user.value != null;
  bool get isInitialized => _isInitialized.value;

  @override
  void onInit() {
    super.onInit();
    debugPrint('AuthService initialized');

    // Listen to Firebase auth state changes
    _firebaseAuth.authStateChanges().listen((firebase_auth.User? firebaseUser) {
      if (firebaseUser != null) {
        _user.value = _createUserFromFirebaseUser(firebaseUser);
        debugPrint('User authenticated: ${firebaseUser.displayName}');
      } else {
        _user.value = null;
        debugPrint('User signed out');
      }

      if (!_isInitialized.value) {
        _isInitialized.value = true;
      }
    });
  }

  Future<bool> signInWithGoogle() async {
    try {
      debugPrint('Starting Google Sign-In process...');
      debugPrint('Package name: com.example.daily_helth_tracker');

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        debugPrint('User canceled the sign-in');
        return false;
      }

      debugPrint('Google Sign-In successful!');
      debugPrint('User: ${googleUser.displayName} (${googleUser.email})');
      debugPrint('Photo URL: ${googleUser.photoUrl}');

      // Try Firebase authentication first
      try {
        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        debugPrint('Got Google authentication tokens');

        // Create a new credential
        final firebase_auth.AuthCredential credential = firebase_auth
            .GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        debugPrint('Signing in to Firebase...');

        // Sign in to Firebase with the Google credential
        final firebase_auth.UserCredential userCredential = await _firebaseAuth
            .signInWithCredential(credential);

        if (userCredential.user != null) {
          debugPrint('Firebase sign-in successful!');
          // Firebase auth state listener will handle setting the user

          AwesomeSnackBarHelper.showSuccess(
            title: 'Welcome!',
            message: 'Successfully signed in with Firebase',
          );

          return true;
        }
      } catch (firebaseError) {
        debugPrint('Firebase authentication failed: $firebaseError');

        // Fall back to using Google Sign-In data directly
        debugPrint('Using Google Sign-In data directly without Firebase');

        _user.value = User(
          id: googleUser.id,
          name: googleUser.displayName ?? 'Unknown User',
          email: googleUser.email,
          photoUrl: googleUser.photoUrl,
        );

        debugPrint('User profile set from Google:');
        debugPrint('- Name: ${_user.value?.name}');
        debugPrint('- Email: ${_user.value?.email}');
        debugPrint('- Photo URL: ${_user.value?.photoUrl}');

        AwesomeSnackBarHelper.showSuccess(
          title: 'Sign In Successful',
          message: 'Welcome ${_user.value?.name ?? 'User'}! (Google Direct)',
        );

        return true;
      }

      return false;
    } catch (e) {
      debugPrint('Google Sign-In Error: $e');

      // Handle specific Google Sign-In configuration errors
      if (e.toString().contains('ApiException: 10')) {
        debugPrint('=== GOOGLE SIGN-IN CONFIGURATION ERROR ===');
        debugPrint('Error: ApiException: 10 (DEVELOPER_ERROR)');
        debugPrint('This means Google Sign-In is not properly configured.');
        debugPrint('');
        debugPrint('To fix this:');
        debugPrint(
          '1. Get SHA-1 fingerprint: cd android && ./gradlew signingReport',
        );
        debugPrint(
          '2. Add SHA-1 to Firebase Console > Project Settings > Your Android App',
        );
        debugPrint('3. Download updated google-services.json');
        debugPrint('4. Run: flutter clean && flutter run');
        debugPrint('=====================================');

        // Show configuration help message
        AwesomeSnackBarHelper.showWarning(
          title: 'Configuration Required',
          message:
              'Google Sign-In needs SHA-1 fingerprint. Using demo mode for now.',
          duration: const Duration(seconds: 5),
        );

        // Create a demo user for testing purposes
        _user.value = User(
          id: 'demo_user_${DateTime.now().millisecondsSinceEpoch}',
          name: 'Demo User',
          email: 'demo@example.com',
          photoUrl: null,
        );

        debugPrint('Demo user created: ${_user.value?.name}');
        return true;
      }

      // Show generic error message for other errors
      AwesomeSnackBarHelper.showError(
        title: 'Sign In Error',
        message: 'Failed to sign in with Google. Please try again.',
      );

      return false;
    }
  }

  Future<void> signOut() async {
    try {
      debugPrint('Signing out...');

      // Check if user is a demo user
      if (_user.value?.id.startsWith('demo_user_') == true) {
        debugPrint('Demo user sign out');
        _user.value = null;

        AwesomeSnackBarHelper.showInfo(
          title: 'Signed Out',
          message: 'Demo session ended successfully!',
        );
        return;
      }

      // Sign out from both Firebase and Google for real users
      await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);

      debugPrint('Sign out successful');

      AwesomeSnackBarHelper.showSuccess(
        title: 'Signed Out',
        message: 'You have been successfully signed out!',
      );
    } catch (e) {
      debugPrint('Sign Out Error: $e');

      AwesomeSnackBarHelper.showWarning(
        title: 'Sign Out Warning',
        message:
            'Signed out but there were some issues. Please try signing in again.',
      );

      // Force sign out even if there's an error
      _user.value = null;
    }
  }

  User _createUserFromFirebaseUser(firebase_auth.User firebaseUser) {
    return User(
      id: firebaseUser.uid,
      name: firebaseUser.displayName ?? '',
      email: firebaseUser.email ?? '',
      photoUrl: firebaseUser.photoURL,
    );
  }

  Stream<User?> get userStream => _user.stream;
}
