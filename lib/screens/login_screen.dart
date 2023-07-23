import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:spotify_clone/provider/internet_provider.dart';
import 'package:spotify_clone/provider/sign_in_provider.dart';
import 'package:spotify_clone/screens/home_screen.dart';
import 'package:spotify_clone/utils/config.dart';
import 'package:spotify_clone/utils/next_screen.dart';
import 'package:spotify_clone/utils/snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _googleController = RoundedLoadingButtonController();
  final _facebookController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black54,
      body: Center(
        // padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage(
                      Config.app_icon,
                    ),
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Log in to Spotify",
                    style: TextStyle(
                        fontFamily: 'Gotham',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 24, left: 14, right: 14),
                    child: RoundedLoadingButton(
                      borderRadius: 25,
                      width: MediaQuery.of(context).size.width * 08,
                      color: Colors.white,
                      successColor: Colors.white,
                      controller: _googleController,
                      onPressed: _googleSignIn,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(Config.google_icon),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            "Sign in with Google",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 14,
                      right: 14,
                    ),
                    child: RoundedLoadingButton(
                      borderRadius: 25,
                      // width: MediaQuery.of(context).size.width * 08,
                      color: Colors.white,
                      successColor: Colors.white,
                      controller: _facebookController,
                      onPressed: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(Config.facebook_icon),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            "Sign in with Facebook",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // handling google sign in
  Future<void> _googleSignIn() async {
    final signProvider = context.read<SignInProvider>();
    final internetProvider = context.read<InternetProvider>();
    await internetProvider.checkInternetConnection();
    if (internetProvider.hasInternet == false) {
      openSnackBar(context, "Check your InternetProvider ", Colors.red);
      _googleController.reset();
      _facebookController.reset();
    } else {
      await signProvider.googleSignInWithGoogle().then(
        (value) {
          if (signProvider.hasError) {
            openSnackBar(context, signProvider.errorCode!, Colors.red);
            _googleController.reset();
          } else {
            // check weather user exist or not
            signProvider.checkUserExist().then(
              (value) async {
                if (value == true) {
                  await signProvider
                      .getUserDataFromFireStore(signProvider.uid)
                      .then(
                        (value) =>
                            signProvider.saveDatatoSharedPreferrences().then(
                                  (value) =>
                                      signProvider.setSignIn().then((value) {
                                    _googleController.success();
                                    handleAfterSignIn();
                                  }),
                                ),
                      );
                } else {
                  signProvider.saveDataInFireStore().then(
                        (value) =>
                            signProvider.saveDatatoSharedPreferrences().then(
                                  (value) => signProvider.setSignIn().then(
                                    (value) {
                                      _googleController.success();
                                      handleAfterSignIn();
                                    },
                                  ),
                                ),
                      );
                }
              },
            );
          }
        },
      );
    }
  }

  void handleAfterSignIn() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      nextScreenReplace(context, const Homescreen());
    });
  }
}
