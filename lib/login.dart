import 'dart:async';

import 'package:doctorandpatient/signup.dart';
import 'package:doctorandpatient/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//
import 'core/utils.dart';
import 'core/size_configuration.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.red,
            title: const Text(
              "Login",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(0.8), BlendMode.dstATop),
                          image: AssetImage("Assets/TELEHEALTH-1.jpeg"))),
                  //  color: Colors.orangeAccent[700],
                  width: getProportionateScreenWidth(900),
                  height: getProportionateScreenHeight(800),
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.all(12),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(30),
                            ),
                            Text(
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 40,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Email',
                                enabled: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(10),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value!.length == 0) {
                                  return "Email cannot be empty";
                                }
                                if (!RegExp(
                                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return ("Please enter a valid email");
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) => setState(() {}),
                              onSaved: (value) {
                                emailController.text = value!;
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            TextFormField(
                              controller: passwordController,
                              obscureText: _isObscure3,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    icon: Icon(_isObscure3
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure3 = !_isObscure3;
                                      });
                                    }),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Password',
                                enabled: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 15.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(10),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                RegExp regex = new RegExp(r'^.{6,}$');
                                if (value!.isEmpty) {
                                  return "Password cannot be empty";
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("please enter valid password min. 6 character");
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) => setState(() {}),
                              onSaved: (value) {
                                passwordController.text = value!;
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              elevation: 5.0,
                              height: getProportionateScreenHeight(40),
                              onPressed: emailController.text.isNotEmpty &&
                                      passwordController.text.isNotEmpty
                                  ? () {
                                      setState(() {
                                        visible = true;
                                      });
                                      signIn(emailController.text,
                                          passwordController.text);
                                    }
                                  : null,
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              color: Colors.red,
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            Visibility(
                                maintainSize: true,
                                maintainAnimation: true,
                                maintainState: true,
                                visible: visible,
                                child: Container(
                                    child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                              ),
                              elevation: 5.0,
                              height: getProportionateScreenHeight(40),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Register(),
                                  ),
                                );
                              },
                              color: Colors.red,
                              child: Text(
                                "Register Now",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Container(
                //   color: Colors.white,
                //   width: MediaQuery.of(context).size.width,
                //   child: Center(
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         SizedBox(
                //           height: getProportionateScreenHeight(20),
                //         ),
                //         MaterialButton(
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.all(
                //               Radius.circular(20.0),
                //             ),
                //           ),
                //           elevation: 5.0,
                //           height: getProportionateScreenHeight(40),
                //           onPressed: () {
                //             // Navigator.pushReplacement(
                //             //   context,
                //             //   MaterialPageRoute(
                //             //     builder: (context) => Register(),
                //             //   ),
                //             // );
                //           },
                //           color: Colors.blue[900],
                //           child: Text(
                //             "Register Now",
                //             style: TextStyle(
                //               color: Colors.white,
                //               fontSize: 20,
                //             ),
                //           ),
                //         ),
                //         SizedBox(
                //           height: getProportionateScreenHeight(15),
                //         ),
                //         Text(
                //           "Made by",
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 40,
                //           ),
                //         ),
                //         SizedBox(
                //           height: getProportionateScreenHeight(5),
                //         ),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Text(
                //               "WEB",
                //               style: TextStyle(
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 30,
                //                 color: Colors.blue[900],
                //               ),
                //             ),
                //             Text(
                //               "FUN",
                //               style: TextStyle(
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 30,
                //                 color: Colors.yellowAccent[400],
                //               ),
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (BuildContext context) => (const SplashScreen()))))
            .onError(
                (error, stackTrace) => Utils().toastMessage(error.toString()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}














// // ignore_for_file: unnecessary_new

// import 'package:doctorandpatient/adminsignup.dart';
// import 'package:doctorandpatient/core/colors.dart';
// import 'package:doctorandpatient/core/utils.dart';
// import 'package:doctorandpatient/home_patient_doctor.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AdminLogin extends StatefulWidget {
//   const AdminLogin({Key? key}) : super(key: key);

//   @override
//   State<AdminLogin> createState() => _AdminLoginState();
// }

// class _AdminLoginState extends State<AdminLogin> {
//   final _foamKey = GlobalKey<FormState>();
//   bool loading = false;
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   final _auth = FirebaseAuth.instance;

//   void login() {
//     setState(() {
//       loading = true;
//     });
//     _auth
//         .signInWithEmailAndPassword(
//             email: emailController.text,
//             password: passwordController.text.toString())
//         .then((value) {
//       Utils().toastMessage(value.user!.email.toString());
//       Get.off(const adminHome());
//       setState(() {
//         loading = false;
//       });
//     }).onError((error, stackTrace) {
//       debugPrint(error.toString());
//       Utils().toastMessage(error.toString());
//       setState(() {
//         loading = false;
//       });
//     });
//   }

//   // void login() {
//   //   _auth
//   //       .signInWithEmailAndPassword(
//   //           email: emailController.text,
//   //           password: passwordController.text.toString())
//   //       .then((value) {
//   //     QuickAlert.show(
//   //       context: context,
//   //       type: QuickAlertType.success,
//   //       titleColor: Colors.blueGrey,
//   //       title: 'complete',
//   //     );
//   //     Get.off(Homepage());
//   //   }).onError((error, stackTrace) {
//   //     QuickAlert.show(
//   //       context: context,
//   //       type: QuickAlertType.error,
//   //       titleColor: Colors.red,
//   //       title: 'Error',
//   //     );
//   //   });
//   // }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.red,
//         title: Text('Admin Login'),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//           child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Login",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
//             ),
//             SizedBox(
//               height: getProportionateScreenHeight(15),
//             ),
//             Row(
//               children: [
//                 Text(
//                   "Don't have an account?",
//                   style: TextStyle(color: Colors.black54),
//                 ),
//                 SizedBox(
//                   width: getProportionateScreenWidth(5),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Get.off(AdminSignup());
//                   },
//                   child: Text(
//                     "Sign Up ",
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: getProportionateScreenHeight(50),
//             ),
//             Container(
//               height: getProportionateScreenHeight(50),
//               //   width: getProportionateScreenWidth(15)0,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.white,
//                   side: BorderSide(
//                     width: getProportionateScreenWidth(1).0,
//                     color: AppColors.btnlogingreyGreen,
//                   ),
//                   shape: new RoundedRectangleBorder(
//                     borderRadius: new BorderRadius.circular(10.0),
//                   ),
//                 ),
//                 onPressed: () {},
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       'Assets/image 1.png',
//                       scale: 4,
//                     ),
//                     SizedBox(
//                       width: getProportionateScreenWidth(3),
//                     ),
//                     Text(
//                       'Continue with Google',
//                       style: TextStyle(color: Colors.black),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: getProportionateScreenHeight(20),
//             ),
//             SizedBox(
//               height: getProportionateScreenHeight(40),
//             ),
//             // Center(
//             //     child: Text(
//             //   'OR',
//             //   style: TextStyle(fontSize: 20),
//             // )),
//             SizedBox(
//               height: getProportionateScreenHeight(20),
//             ),
//             Form(
//                 key: _foamKey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       keyboardType: TextInputType.emailAddress,
//                       controller: emailController,
//                       decoration: const InputDecoration(
//                         prefixIcon: Icon(Icons.alternate_email),
//                         hintText: 'Email',
//                       ),
//                       validator: (Value) {
//                         if (Value!.isEmpty) {
//                           return "Enter email";
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(
//                       height: getProportionateScreenHeight(20),
//                     ),
//                     TextFormField(
//                       controller: passwordController,
//                       obscureText: true,
//                       decoration: const InputDecoration(
//                         prefixIcon: Icon(Icons.lock_open),
//                         hintText: 'Password',
//                       ),
//                       validator: (Value) {
//                         if (Value!.isEmpty) {
//                           return "Enter Password";
//                         }
//                         return null;
//                       },
//                     ),
//                   ],
//                 )),
//             const SizedBox(
//               height: getProportionateScreenHeight(90),
//             ),
//             Center(
//               child: SizedBox(
//                 height: getProportionateScreenHeight(50),
//                 width: getProportionateScreenWidth(300),
//                 //   width: getProportionateScreenWidth(15)0,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     // side: BorderSide(
//                     //   width: getProportionateScreenWidth(1).0,
//                     //   color: Colors.blueAccent,
//                     // ),
//                     shape: new RoundedRectangleBorder(
//                       borderRadius: new BorderRadius.circular(20),
//                     ),
//                   ),
//                   onPressed: () {
//                     //  Get.off(adminHome());
//                     if (_foamKey.currentState!.validate()) {
//                       login();
//                     }
//                   },
//                   child: Center(
//                     child: loading
//                         ? const CircularProgressIndicator(
//                             strokewidth: getProportionateScreenWidth(3),
//                             color: Colors.white,
//                           )
//                         : const Text(
//                             'Login',
//                             style: TextStyle(color: Colors.white, fontSize: 20),
//                           ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       )),
//     );
//   }
// }
