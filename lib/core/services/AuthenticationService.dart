import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_provider/core/viewmodels/BaseViewModel.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }


class AuthenticationService extends BaseViewModel {

  User user;
  StreamSubscription userAuthSub;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Status _status = Status.Uninitialized;
  Status get status => _status;

  AuthenticationService() {
    userAuthSub = _firebaseAuth.authStateChanges().listen((newUser) {
      print('AuthProvider - FirebaseAuth - onAuthStateChanged - $newUser');
      if (newUser == null) {
        _status = Status.Unauthenticated;
      } else {
        _status = Status.Authenticated;
      }

      user = newUser;
      notifyListeners();
    }, onError: (e) {
      print('AuthProvider - FirebaseAuth - onAuthStateChanged - $e');
    });
  }


  @override
  void dispose() {
    if (userAuthSub != null) {
      userAuthSub.cancel();
      userAuthSub = null;
    }
    super.dispose();
  }

  Future<void> signUpWithEmail({@required String email, @required String password}) async {
    setBusy(true);
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    setBusy(false);
  }

  Future<void> signInWithEmail({@required String email, @required String password}) async {
    setBusy(true);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }

      print(e.message);
    }
    setBusy(false);
  }

  Future<void> signOut() async {
    _status = Status.Unauthenticated;
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }

}