import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:spotify_clone/utils/config.dart';

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
                      onPressed: () {},
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
}
  
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(left: 14, right: 14),
            //       child: RoundedLoadingButton(
            //         borderRadius: 25,
            //         width: MediaQuery.of(context).size.width * 08,
            //         color: Colors.white,
            //         successColor: Colors.white,
            //         controller: _googleController,
            //         onPressed: () {},
            //         child: const Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             CircleAvatar(
            //               radius: 15,
            //               backgroundColor: Colors.white,
            //               backgroundImage: AssetImage(Config.google_icon),
            //             ),
            //             SizedBox(
            //               width: 15,
            //             ),
            //             Text(
            //               textAlign: TextAlign.center,
            //               "Sign in with Google",
            //               style: TextStyle(color: Colors.black),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //     const SizedBox(
            //       height: 16,
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(
            //         left: 14,
            //         right: 14,
            //       ),
            //       child: RoundedLoadingButton(
            //         borderRadius: 25,
            //         width: MediaQuery.of(context).size.width * 08,
            //         color: Colors.white,
            //         successColor: Colors.white,
            //         controller: _facebookController,
            //         onPressed: () {},
            //         child: const Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             CircleAvatar(
            //               radius: 15,
            //               backgroundColor: Colors.white,
            //               backgroundImage: AssetImage(Config.facebook_icon),
            //             ),
            //             SizedBox(
            //               width: 15,
            //             ),
            //             Text(
            //               textAlign: TextAlign.center,
            //               "Sign in with Facebook",
            //               style: TextStyle(color: Colors.black),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // )
    // var _userMail = '';
  // var _userUsername = '';

//   final _key = GlobalKey<FormState>();
//   void _saveUser() {
//     final isValid = _key.currentState!.validate();
//     if (!isValid) {
//       return;
//     }
//     _key.currentState!.save();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.onBackground,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.onPrimary,
//         elevation: 0,
//       ),
//       body: Center(
//         child: Container(
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
//           width: 300,
//           child: Form(
//             key: _key,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextFormField(
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null ||
//                         value.isEmpty ||
//                         !value.contains('@')) {
//                       return "Please provide a valid mail ";
//                     }
//                     return null;
//                   },
//                   onSaved: (newValue) {
//                     _userMail = newValue!;
//                   },
//                   decoration: const InputDecoration(
//                     labelText: 'email',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(24),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 14,
//                 ),
//                 TextFormField(
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null ||
//                         value.isEmpty ||
//                         value.trim().length < 5) {
//                       return "Please provide a valid  Username";
//                     }
//                     return null;
//                   },
//                   onSaved: (newValue) {
//                     _userUsername = newValue!;
//                   },
//                   decoration: const InputDecoration(
//                     labelText: 'Username',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(24),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 14,
//                 ),
//                 ElevatedButton(
//                   onPressed: _saveUser,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(253, 31, 241, 104),
//                     shape: const StadiumBorder(),
//                   ),
//                   child: const Text(
//                     "   Log in   ",
//                     style: TextStyle(color: Colors.black, fontFamily: 'Gotham'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
