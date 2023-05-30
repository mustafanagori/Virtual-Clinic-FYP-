import 'dart:async';

import 'package:doctorandpatient/templetes/doctors_screen/personal_info_Doc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../signup.dart';
import '../../core/utils.dart';
import '../../core/size_configuration.dart';

class Rejected extends StatelessWidget {
  const Rejected({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: [
        Image.asset(
          "Assets/TELEHEALTH-1.jpeg",
          fit: BoxFit.cover,
          height: getProportionateScreenHeight(780),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 106, 96),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                height: getProportionateScreenHeight(180),
                width: getProportionateScreenWidth(320),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Your account verification is rejected by admin kindly \n resubmit the form with correct information',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              SizedBox(
                height: getProportionateScreenHeight(50),
                width: getProportionateScreenWidth(200),
                //   width: getProportionateScreenWidth(15)0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    // side: BorderSide(
                    //   width: getProportionateScreenWidth(1).0,
                    //   color: Colors.blueAccent,
                    // ),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    Timer(
                        Duration(seconds: 1),
                        () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                (PersonalInfo()))));
                  },
                  child: Text(
                    'Resubmit Form',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(300),
              ),
              SizedBox(
                height: getProportionateScreenHeight(50),
                width: getProportionateScreenWidth(300),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    FirebaseAuth.instance.signOut().then((value) {
                      Get.off(Register());
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                    });
                  },
                  child: Text(
                    'Logout',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    )));
    SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Center(
              child: Text(
                  "You are rejected by admin kindly re submit the form with correct information"),
            ),
            ElevatedButton(
                onPressed: () {
                  Timer(
                      Duration(seconds: 3),
                      () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  (PersonalInfo()))));
                },
                child: Text("Resubmit Form")),
            SizedBox(
              height: getProportionateScreenHeight(300),
            ),
            SizedBox(
              height: getProportionateScreenHeight(50),
              width: getProportionateScreenWidth(300),
              //   width: getProportionateScreenWidth(15)0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  // side: BorderSide(
                  //   width: getProportionateScreenWidth(1).0,
                  //   color: Colors.blueAccent,
                  // ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20),
                  ),
                ),
                onPressed: () async {
                  FirebaseAuth.instance.signOut().then((value) {
                    Get.off(Register());
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                  });
                },
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
