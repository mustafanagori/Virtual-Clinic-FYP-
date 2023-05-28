import 'package:doctorandpatient/core/size_configuration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../adminsignup.dart';
import '../../core/utils.dart';

class DoctorVerification extends StatelessWidget {
  const DoctorVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: [
        Image.asset(
          "Assets/TELEHEALTH-1.jpeg",
          fit: BoxFit.cover,
          height: getProportionateScreenHeight(770),
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
                height: getProportionateScreenHeight(100),
                width: getProportionateScreenWidth(360),
                child: const Center(
                  child: Text(
                    'Your Account Verification \n         Is in Processing',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ),
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
        )
      ],
    )));
  }
}
