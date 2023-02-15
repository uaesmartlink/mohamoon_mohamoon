import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mohamoon_mohamoon/app/services/lawyer_service.dart';
import 'package:mohamoon_mohamoon/app/services/user_service.dart';

import 'firebase_service.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  Future login(String username, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: username, password: password);
      UserService.user = _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      return Future.error(e.message!);
    }
  }

  Future regiterNewUser(String username, String email, String password) async {
    try {
      print('masuk sini kok');
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('masuk sini kok1');
      UserService.user = result.user;
      await UserService.user!.updateDisplayName(username);
      await FirebaseService().userSetup(result.user!, username);
    } on FirebaseAuthException catch (e) {
      return Future.error(e.message!);
    } on SocketException catch (e) {
      return Future.error(e.message);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  /// for checking user password, ex change password, withdraw balance need passsword
  Future<bool> verifyPassword(String password) async {
    try {
      var firebaseUser = _auth.currentUser!;
      var authCredential = EmailAuthProvider.credential(
          email: firebaseUser.email!, password: password);
      var authResult =
          await firebaseUser.reauthenticateWithCredential(authCredential);
      return authResult.user != null;
    } on FirebaseAuthException catch (e) {
      return Future.error(e.message!);
    }
  }

  Future resetPassword(String email) async {
    try {
      _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //check whether user is already set his the lawyer detail or not
  Future<bool> checkLawyerDetail() async {
    try {
      String lawyerId = await UserService().getLawyerId();
      // var lawyerReferences = await FirebaseFirestore.instance
      //     .collection('Users')
      //     .where('lawyerId', isEqualTo: lawyerId)
      //     .get();
      if (lawyerId.isNotEmpty) return true;
      return false;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //check whether user is lawyer or not
  Future<bool> isUserLawyer() async {
    var userReferences = await FirebaseFirestore.instance
        .collection('Users')
        .doc(UserService.user!.uid)
        .get();
    var user = userReferences.data() as Map<String, dynamic>;
    var role = user['role'] as String;
    if (role == 'lawyer') return true;
    return false;
  }


  Future logout() async {
    LawyerService().makeOffline();
    LawyerService.lawyer!.isOnline = false;
    LawyerService.lawyer = null;
  }
}
