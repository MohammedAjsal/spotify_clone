import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _hasError = false;
  bool get hasError => _hasError;

  String? _errorCode;
  String? get errorCode => _errorCode;

  String? _provider;
  String? get povider => _provider;

  String? _name;
  String? get name => _name;

  String? _imageUrl;
  String? get imageUrl => _imageUrl;

  String? _uid;
  String? get uid => _uid;

  String? _email;
  String? get email => _email;

  SignInProvider() {
    checkSignInUser();
  }

  Future checkSignInUser() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("signed_in") ?? false;
    notifyListeners();
  }

  Future<void> setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("signed_in", true);
    _isSignedIn = true;
    notifyListeners();
  }

  Future<void> googleSignInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();

    if (googleSignInAccount != null) {
      try {
        final GoogleSignInAuthentication _googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credentials = GoogleAuthProvider.credential(
            accessToken: _googleSignInAuthentication.accessToken,
            idToken: _googleSignInAuthentication.accessToken);
        // signin firebase user instance
        final User userDetails =
            (await _firebaseAuth.signInWithCredential(credentials)).user!;
        // save values
        _name = userDetails.displayName;
        _email = userDetails.email;
        _uid = userDetails.uid;
        _provider = "GOOGLE";
        _imageUrl = userDetails.photoURL;
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'account-exists-with-different-credentia':
            _errorCode = "Already have an account ";
            _hasError = true;
            notifyListeners();
            break;
          case "null":
            _errorCode =
                "Some unexpected error occured while trying to sign in ";
            _hasError = true;
            notifyListeners();
            break;
          default:
            _errorCode = e.toString();
            _hasError = true;
            notifyListeners();
        }
      }
    } else {
      _hasError = true;
      notifyListeners();
    }
  }

  // get userdata from database
  Future<void> getUserDataFromFireStore(uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) => {
              _name = snapshot['name'],
              _uid = snapshot['uid'],
              _email = snapshot['email'],
              _provider = snapshot['provider'],
              _imageUrl = snapshot['imageUrl'],
            });
  }

// save data of user in firebase
  Future<void> saveDataInFireStore() async {
    final DocumentReference r =
        await FirebaseFirestore.instance.collection('user').doc(uid);
    await r.set({
      'name': _name,
      'uid': _uid,
      'email': _email,
      'provider': _provider,
      'image': _imageUrl,
    });
    notifyListeners();
  }

  Future<void> saveDatatoSharedPreferrences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString('name', _name!);
    await s.setString('uid', _uid!);
    await s.setString('email', _email!);
    await s.setString('image_url', _imageUrl!);
    await s.setString('provider', _provider!);
    notifyListeners();
  }
  // user exist or not  in cloudFireStore

  Future<bool> checkUserExist() async {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (snap.exists) {
      return true;
    } else {
      return false;
    }
  }

  // signout
  Future<void> userSignOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
    _isSignedIn = false;
    notifyListeners();
    clearStoredData();
  }

  Future<void> clearStoredData() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.clear();
  }
}
