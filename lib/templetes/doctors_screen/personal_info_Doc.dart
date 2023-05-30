import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorandpatient/core/utils.dart';

import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:doctorandpatient/templetes/doctors_screen/doctorhome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../controller/doctors_controller.dart';
import '../../core/size_configuration.dart';
import '../../splashscreen.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  bool loading = false;
  final currentUserid = FirebaseAuth.instance.currentUser!.uid;
  //SkillsController
  TextEditingController skillController = TextEditingController();
  List skills = [];
  List certication = [];

  String? gender;
  void addskills() {
    String skill = skillController.text.toString();
    setState(() {
      skills.add(skill);
    });
  }

// cetfications
  TextEditingController instituteController = TextEditingController();
  void addcertification() {
    String instituteName = instituteController.text.toString();

    setState(() {
      certication.add(instituteName);
    });
  }

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final contactController = TextEditingController();
  final prnoController = TextEditingController();
  final cnicController = TextEditingController();
  final emailController = TextEditingController();
  final universityNameController = TextEditingController();
  final degreeProgramController = TextEditingController();
  final passyearController = TextEditingController();
  final cgpaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red, title: Text('Dr Verification Form')),
      body: Container(
        height: getProportionateScreenHeight(730),
        width: getProportionateScreenWidth(376),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.dstATop),
                image: AssetImage("Assets/pexels-pixabay-40568.jpeg"))),
        child: ListView(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: getProportionateScreenWidth(170),
                  child: TextFormField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: getProportionateScreenWidth(20),
                                color: Colors.red),
                            borderRadius: BorderRadius.circular(20)),
                        labelText: "First Name"),
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(170),
                  child: TextFormField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: getProportionateScreenWidth(4),
                                color: Colors.red),
                            borderRadius: BorderRadius.circular(20)),
                        labelText: "Last Name"),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: getProportionateScreenWidth(170),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: contactController,
                    maxLength: 11,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: getProportionateScreenWidth(1),
                                color: Colors.red),
                            borderRadius: BorderRadius.circular(20)),
                        labelText: "Contact No"),
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(170),
                  child: TextFormField(
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    controller: prnoController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: getProportionateScreenWidth(20),
                                color: Colors.red),
                            borderRadius: BorderRadius.circular(20)),
                        labelText: "PRNO#"),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: getProportionateScreenWidth(170),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 13,
                    controller: cnicController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: getProportionateScreenWidth(1),
                                color: Colors.red),
                            borderRadius: BorderRadius.circular(20)),
                        labelText: "CNIC NO"),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                RadioListTile(
                  title: Text("Male"),
                  value: "male",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: Text("Female"),
                  value: "female",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                ),
                Text(
                  "Education",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: getProportionateScreenWidth(170),
                      child: TextFormField(
                        controller: universityNameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: getProportionateScreenWidth(20),
                                    color: Colors.red),
                                borderRadius: BorderRadius.circular(20)),
                            labelText: "University Name"),
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(170),
                      child: TextFormField(
                        controller: degreeProgramController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: getProportionateScreenWidth(20),
                                    color: Colors.red),
                                borderRadius: BorderRadius.circular(20)),
                            labelText: "Degree Program"),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: getProportionateScreenWidth(170),
                      child: TextFormField(
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        controller: passyearController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: getProportionateScreenWidth(20),
                                    color: Colors.red),
                                borderRadius: BorderRadius.circular(20)),
                            labelText: "Years of Passing"),
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(170),
                      child: TextFormField(
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                        controller: cgpaController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: getProportionateScreenWidth(20),
                                    color: Colors.red),
                                borderRadius: BorderRadius.circular(20)),
                            labelText: "CGPA"),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Text(
                  "Add Skills",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: getProportionateScreenWidth(320),
                      child: TextFormField(
                        controller: skillController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: getProportionateScreenWidth(20),
                                    color: Colors.red),
                                borderRadius: BorderRadius.circular(20)),
                            labelText: "Add Skills"),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          if (skillController.text.isNotEmpty) {
                            addskills();
                          }
                        },
                        child: Icon(Icons.add))
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(50),
                  width: getProportionateScreenWidth(375),
                  // color: Colors.grey.shade300,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: skills.length,
                      itemBuilder: ((context, index) {
                        return Row(
                          children: [
                            Chip(
                              elevation: 20,
                              padding: EdgeInsets.all(8),
                              backgroundColor: Colors.red,
                              // shadowColor: Colors.black,
                              label: Text(
                                '${skills[index]}',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      })),
                ),
                Text(
                  "Certification",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: getProportionateScreenWidth(320),
                      child: TextFormField(
                        controller: instituteController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: getProportionateScreenWidth(20),
                                    color: Colors.red),
                                borderRadius: BorderRadius.circular(20)),
                            labelText: "Specialization"),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          addcertification();
                        },
                        child: Icon(Icons.add))
                  ],
                ),
                // new
                SizedBox(
                  height: getProportionateScreenHeight(50),
                  width: getProportionateScreenWidth(380),
                  // color: Colors.grey.shade200,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: certication.length,
                      itemBuilder: ((context, index) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Chip(
                            elevation: 20,
                            padding: EdgeInsets.all(8),
                            backgroundColor: Colors.red,
                            // shadowColor: Colors.black,
                            label: Text(
                              '${certication[index]}',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        );
                      })),
                ),

                Container(
                  height: getProportionateScreenHeight(50),
                  width: getProportionateScreenWidth(350),
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
                      setState(() {
                        loading = true;
                      });
                      await FirebaseFirestore.instance
                          .collection("doctors")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set({
                        "rating": [0],
                        "firstName": firstNameController.text.toString(),
                        "lastName": lastNameController.text.toString(),
                        "contact": contactController.text.toString(),
                        "prno": prnoController.text.toString(),
                        "cnic": cnicController.text.toString(),
                        "gender": gender.toString(),
                        "uniname": universityNameController.text.toString(),
                        "degprogram": degreeProgramController.text.toString(),
                        "passyear": passyearController.text.toString(),
                        "cgpa": cgpaController.text.toString(),
                        "skills": skills.toString(),
                        "spealization": certication.toString(),
                      }).then((value) async {
                        Utils().toastMessage("Data Added");
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          "isVerified": "inProcess",
                        });
                        Get.put(DoctorController());
                        Get.off(SplashScreen());

                        setState(() {
                          loading = false;
                        });
                      }).onError((error, stackTrace) {
                        Utils().toastMessage(error.toString());
                        setState(() {
                          loading = false;
                        });
                      });
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(2),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
