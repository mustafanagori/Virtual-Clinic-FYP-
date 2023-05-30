import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorandpatient/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'core/utils.dart';
import 'core/size_configuration.dart';
// import 'model.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  _RegisterState();

  bool showProgress = false;
  bool visible = false;
  bool confrimPass = false;
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmpassController =
      new TextEditingController();
  final TextEditingController name = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController mobile = new TextEditingController();
  bool _isObscure = true;
  File? file;
  var options = [
    'Patient',
    'Doctor',
  ];
  var _currentItemSelected = "Patient";
  var rool = "Patient";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Registeration",
              style: TextStyle(fontSize: 30),
            ),
            backgroundColor: Colors.red,
          ),
          // backgroundColor: Colors.red,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(
                                Colors.black.withOpacity(0.8),
                                BlendMode.dstATop),
                            image: AssetImage("Assets/TELEHEALTH-1.jpeg"))),
                    //    color: Colors.orangeAccent[700],
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.all(12),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: getProportionateScreenHeight(80),
                              ),
                              Text(
                                "Register Now",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 40,
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(50),
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
                                    borderRadius: new BorderRadius.circular(20),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.white),
                                    borderRadius: new BorderRadius.circular(20),
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
                                onChanged: (value) {},
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(20),
                              ),
                              TextFormField(
                                obscureText: _isObscure,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      icon: Icon(_isObscure
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
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
                                    borderRadius: new BorderRadius.circular(20),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.white),
                                    borderRadius: new BorderRadius.circular(20),
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
                                onChanged: (value) {},
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(20),
                              ),
                              TextFormField(
                                obscureText: _isObscure,
                                controller: confirmpassController,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      icon: Icon(_isObscure
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      }),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Confirm Password',
                                  enabled: true,
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 15.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.white),
                                    borderRadius: new BorderRadius.circular(20),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.white),
                                    borderRadius: new BorderRadius.circular(20),
                                  ),
                                ),
                                validator: (value) {
                                  if (confirmpassController.text !=
                                      passwordController.text) {
                                    return "Password did not match";
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {},
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(40),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Types : ",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    dropdownColor: Colors.red,
                                    isDense: true,
                                    isExpanded: false,
                                    iconEnabledColor: Colors.black,
                                    focusColor: Colors.black,
                                    items: options
                                        .map((String dropDownStringItem) {
                                      return DropdownMenuItem<String>(
                                        value: dropDownStringItem,
                                        child: Text(
                                          dropDownStringItem,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValueSelected) {
                                      setState(() {
                                        _currentItemSelected =
                                            newValueSelected!;
                                        rool = newValueSelected;
                                      });
                                    },
                                    value: _currentItemSelected,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(60),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    elevation: 5.0,
                                    height: getProportionateScreenHeight(40),
                                    onPressed: () {
                                      CircularProgressIndicator();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginPage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                    color: Colors.red,
                                  ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    elevation: 5.0,
                                    height: getProportionateScreenHeight(40),
                                    onPressed: () {
                                      setState(() {
                                        showProgress = true;
                                      });
                                      try {
                                        signUp(emailController.text,
                                            passwordController.text, rool);
                                      } catch (e) {
                                        Utils().toastMessage(e.toString());
                                      }
                                    },
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password, String rool) async {
    CircularProgressIndicator();
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore(email, rool)})
          // ignore: body_might_complete_normally_catch_error
          .catchError((e) {
        Utils().toastMessage(e.toString());
      });
    }
  }

  postDetailsToFirestore(String email, String rool) async {
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({
      'email': emailController.text,
      'rool': rool,
      'isVerified': "needData"
    });
    
    Utils().toastMessage("Registered Sucessfully");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}











// import 'package:doctorandpatient/adminlogin.dart';
// import 'package:doctorandpatient/core/colors.dart';
// import 'package:doctorandpatient/core/utils.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AdminSignup extends StatefulWidget {
//   const AdminSignup({Key? key}) : super(key: key);

//   @override
//   State<AdminSignup> createState() => _AdminSignupState();
// }

// class _AdminSignupState extends State<AdminSignup> {
//   final _foamKey = GlobalKey<FormState>();

//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final _auth = FirebaseAuth.instance;
//   bool loading = false;

//   void Signup() {
//     setState(() {
//       loading = true;
//     });

//     _auth
//         .createUserWithEmailAndPassword(
//             email: emailController.text.toString(),
//             password: passwordController.text.toString())
//         .then((value) {
//       setState(() {
//         loading = false;
//       });
//     }).onError((error, stackTrace) {
//       Utils().toastMessage(error.toString());
//     }).onError((error, stackTrace) {
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
//         title: Text('Admin Signup'),
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
//               "Sign up",
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
//                     Get.off(AdminLogin());
//                   },
//                   child: Text(
//                     "Login ",
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
//                     SizedBox(
//                       height: getProportionateScreenHeight(20),
//                     ),
//                     TextFormField(
//                       controller: passwordController,
//                       obscureText: true,
//                       decoration: const InputDecoration(
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
//             SizedBox(
//               height: getProportionateScreenHeight(90),
//             ),
//             Center(
//               child: Container(
//                 height: getProportionateScreenHeight(50),
//                 width: getProportionateScreenWidth(300),
//                 //   width: getProportionateScreenWidth(15)0,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.red,
//                     // side: BorderSide(
//                     //   width: getProportionateScreenWidth(1).0,
//                     //   color: Colors.blueAccent,
//                     // ),
//                     shape: new RoundedRectangleBorder(
//                       borderRadius: new BorderRadius.circular(20),
//                     ),
//                   ),
//                   onPressed: () {
//                     if (_foamKey.currentState!.validate()) {
//                       Signup();
//                     }
//                   },
//                   child: Center(
//                     child: loading
//                         ? CircularProgressIndicator(
//                             strokewidth: getProportionateScreenWidth(3),
//                             color: Colors.white,
//                           )
//                         : Text(
//                             'Sign UP',
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
