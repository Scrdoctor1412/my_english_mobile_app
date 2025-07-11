import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/service/leitner_box_service.dart';
import 'package:englens/src/service/local_notification_service.dart';
import 'package:englens/src/ui/screens/login/login_screen.dart';
import 'package:englens/src/ui/screens/tabs/tabs_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends GetViewModelBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  // User? user;
  var user = Rx<User?>(null);

  @override
  void onReady() {
    super.onReady();
    user.bindStream(_firebaseAuth.authStateChanges());
    ever(user, _setInitialScreen);
  }

  void _setInitialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => TabsScreen());
      var todayWords = await LeitnerBoxService.getTodaysWords();
      if (todayWords.isNotEmpty) {
        LocalNotificationService.showSimpleNotification(
          id: 1,
          title: "Daily Words",
          body: "You have ${todayWords.length} words to learn today",
        );
      }
    }
  }

  Future<bool> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return false; // Người dùng hủy đăng nhập

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
      return true;
    } catch (e) {
      debugPrint('firebase login error: ${e.toString()}');
      Get.snackbar("Login Error", e.toString());
      return false;
    }
  }

  ///Firebase sign in with Email and Password
  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      // final user = <String, dynamic>{
      //   'uid': userCredential.user!.uid,
      //   'email': email,
      //   "first": "Ada",
      //   "last": "Lovelace",
      // };

      // _fireStore.collection('users').add(user);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      Get.snackbar(
          "Thành công", "Vui lòng kiểm tra email để đặt lại mật khẩu.");
    } catch (e) {
      Get.snackbar("Lỗi", "Không thể gửi email. Kiểm tra lại địa chỉ email.");
    }
  }

  //sign out
  Future<void> signOut() async {
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}
