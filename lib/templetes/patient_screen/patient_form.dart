import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorandpatient/core/utils.dart';
import 'package:doctorandpatient/login.dart';

import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:doctorandpatient/templetes/doctors_screen/doctorhome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../controller/patient_controller.dart';
import '../../core/size_configuration.dart';
import '../../splashscreen.dart';

class PatientInfo extends StatefulWidget {
  const PatientInfo({super.key});

  @override
  State<PatientInfo> createState() => _PatientInfoState();
}

class _PatientInfoState extends State<PatientInfo> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  final currentUserid = FirebaseAuth.instance.currentUser!.uid;
  String? gender;

  final firstNameController = TextEditingController();

  final contactController = TextEditingController();
  final cnicController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Patient Information'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.to(LoginPage());
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.dstATop),
                  image: AssetImage("Assets/pexels-pixabay-40568.jpeg"))),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(50),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: getProportionateScreenWidth(250),
                      child: TextFormField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: getProportionateScreenWidth(3),
                                    color: Colors.red),
                                borderRadius: BorderRadius.circular(20)),
                            labelText: "Patient Name"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "cannot be empty";
                          }
                          if (value.length < 3) {
                            return "minimum length of 3";
                          }
                          if (value.contains(RegExp(r'[0-9]'))) {
                            return "cannot contain numbers";
                          }
                          if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                            return "must contain only alphabetic characters and spaces";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                        keyboardType: TextInputType.name,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: getProportionateScreenWidth(250),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        maxLength: 11,
                        controller: contactController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: getProportionateScreenWidth(3),
                                    color: Colors.red),
                                borderRadius: BorderRadius.circular(20)),
                            labelText: "Contact No"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "cannot be empty";
                          }
                          if (value.length != 11 ||
                              !RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return "Invalid contain 13 digits";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: getProportionateScreenWidth(250),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 13,
                        controller: cnicController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: getProportionateScreenWidth(3),
                                    color: Colors.red),
                                borderRadius: BorderRadius.circular(20)),
                            labelText: "CNIC NO"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "cannot be empty";
                          }
                          if (value.length != 13 ||
                              !RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return "contain 13 digits only  ";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    RadioListTile(
                      title: const Text("Male"),
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
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(250),
                ),
                Container(
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
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        await FirebaseFirestore.instance
                            .collection("patients")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .set({
                          "name": firstNameController.text.toString(),
                          "contact": contactController.text.toString(),
                          "cnic": cnicController.text.toString(),
                          "gender": gender.toString(),
                        }).then((value) async {
                          Utils().toastMessage("Data Added");
                          Get.put(PatientController());

                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            "isVerified": "verified",
                          });

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
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(15),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
