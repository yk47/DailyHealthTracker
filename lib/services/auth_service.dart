import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../models/user.dart';

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
    // For development, set initialized to true immediately
    _isInitialized.value = true;

    // Try to listen to Firebase auth state changes
    try {
      _firebaseAuth.authStateChanges().listen((
        firebase_auth.User? firebaseUser,
      ) {
        if (firebaseUser != null) {
          _user.value = _createUserFromFirebaseUser(firebaseUser);
        } else {
          _user.value = null;
        }
        // Mark as initialized after first auth state change
        if (!_isInitialized.value) {
          _isInitialized.value = true;
        }
      });
    } catch (e) {
      debugPrint('Firebase Auth initialization error: $e');
      // If Firebase isn't configured, we'll still work with Google Sign-In only
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign-in
        return false;
      }

      // Try Firebase Auth first
      try {
        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Create a new credential
        final firebase_auth.AuthCredential credential = firebase_auth
            .GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with the Google credential
        final firebase_auth.UserCredential userCredential = await _firebaseAuth
            .signInWithCredential(credential);

        if (userCredential.user != null) {
          _user.value = _createUserFromFirebaseUser(userCredential.user!);
          return true;
        }
      } catch (firebaseError) {
        debugPrint(
          'Firebase Auth error, falling back to Google Sign-In only: $firebaseError',
        );

        // Fallback: Use Google Sign-In data directly
        _user.value = User(
          id: googleUser.id,
          name: googleUser.displayName ?? '',
          email: googleUser.email,
          photoUrl: googleUser.photoUrl,
        );
        return true;
      }

      return false;
    } catch (e) {
      debugPrint('Google Sign-In Error: $e');
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      // Sign out from both Firebase and Google
      await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
      _user.value = null;
    } catch (e) {
      debugPrint('Sign Out Error: $e');
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
