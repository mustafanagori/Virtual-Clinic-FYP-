import 'package:doctorandpatient/signup.dart';
import 'package:doctorandpatient/core/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/patient_controller.dart';
import '../../core/size_configuration.dart';

class mypProfile extends StatefulWidget {
  const mypProfile({Key? key}) : super(key: key);

  @override
  State<mypProfile> createState() => _mypProfileState();
}

class _mypProfileState extends State<mypProfile> {
  final currentUser = FirebaseAuth.instance.currentUser;

  final patientController = Get.find<PatientController>();
  @override
  @override
  Widget build(BuildContext context) {
    final patientModel = patientController.getPatientById(currentUser!.uid);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          // leading: Padding(
          //   padding: const EdgeInsets.only(left: 12.0),
          //   child: Container(
          //     height: getProportionateScreenHeight(6),
          //     width: getProportionateScreenWidth(6),
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       border: Border.all(
          //         color: Colors.grey.shade300,
          //         width: getProportionateScreenWidth(2).0,
          //       ),
          //     ),
          //     child: Center(
          //       child: GestureDetector(
          //         child: const Icon(
          //           Icons.arrow_back_ios,
          //           color: Colors.black,
          //         ),
          //         onTap: () {
          //           //   Get.back();
          //         },
          //       ),
          //     ),
          //   ),
          // ),
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                height: getProportionateScreenHeight(6),
                width: getProportionateScreenWidth(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: .0,
                  ),
                ),
                child: GestureDetector(
                    child: Image.asset(
                      'Assets/Edit-Square.png',
                      scale: 4,
                    ),
                    onTap: () {
                      //    Get.to();
                    }),
              ),
            ),
          ],
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.dstATop),
                  image: AssetImage("Assets/TELEHEALTH-1.jpeg"))),
          child: ListView(children: [
            Center(
              child: SizedBox(
                height: getProportionateScreenHeight(200),
                width: getProportionateScreenWidth(100),
                child: CircleAvatar(
                  child: Image.asset(
                    'Assets/Ellipse.png',
                    scale: 4,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40, left: 6),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Name",
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 6),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    patientModel.name.toString(),
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 6),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 6),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    currentUser!.email.toString(),
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(top: 3, left: 6),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Phone Number',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 3, left: 6),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    patientModel.contact,
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(top: 3, left: 6),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Gender',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 3, left: 6),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    patientModel.gender,
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            Divider(),
            SizedBox(
              height: getProportionateScreenHeight(40),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    // side: BorderSide(
                    //   width: getProportionateScreenWidth(1).0,
                    //   color: Colors.blueAccent,
                    // ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      Get.off(Register());
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                    });
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
            )
          ]),
        )));
  }
}
