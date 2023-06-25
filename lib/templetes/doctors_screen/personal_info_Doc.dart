import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorandpatient/core/utils.dart';
import 'package:doctorandpatient/login.dart';

import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:doctorandpatient/templetes/doctors_screen/doctorhome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  final _formKey = GlobalKey<FormState>();
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
      skillController.text = "";
    });
  }

  void removeskill(String skill) {
    setState(() {
      skills.remove(skill);
    });
  }

// cetfications
  TextEditingController certificateController = TextEditingController();
  void addcertification() {
    String instituteName = certificateController.text.toString();

    setState(() {
      certication.add(instituteName);
      certificateController.text = "";
    });
  }

  void removecertification(String certification) {
    setState(() {
      certication.remove(certification);
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
        leading: IconButton(
            onPressed: () {
              Get.to(LoginPage());
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.red,
        title: const Text('Dr Verification Form'),
        centerTitle: true,
      ),
      body: Container(
        height: getProportionateScreenHeight(730),
        width: getProportionateScreenWidth(376),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.dstATop),
                image: const AssetImage("Assets/pexels-pixabay-40568.jpeg"))),
        child: Form(
          key: _formKey,
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
                        if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                          return "contain alphabetic";
                        }
                        return null;
                      },
                      onChanged: (value) {},
                      keyboardType: TextInputType.name,
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
                          if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                            return "contain alphabetic";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                        keyboardType: TextInputType.name),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "cannot be empty";
                        }
                        if (value.length != 11 ||
                            !RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return "Invalid number ";
                        }
                        return null;
                      },
                      onChanged: (value) {},
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "cannot be empty";
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return "contain number";
                        }
                        return null;
                      },
                      onChanged: (value) {},
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "cannot be empty";
                        }
                        if (value.length != 13 ||
                            !RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return "contain 13 digits ";
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
                    title: const Text("Female"),
                    value: "female",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                  const Text(
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "cannot be empty";
                            }
                            if (value.contains(RegExp(r'[0-9]'))) {
                              return "cannot be numbers";
                            }
                            return null;
                          },
                          onChanged: (value) {},
                          keyboardType: TextInputType.name,
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "cannot be empty";
                            }
                            if (value.contains(RegExp(r'[0-9]'))) {
                              return "cannot contain numbers";
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "cannot be empty";
                            }
                            int? year = int.tryParse(value);
                            if (year == null || year > 2023) {
                              return "Invalid year";
                            }
                            return null;
                          },
                          onChanged: (value) {},
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(170),
                        child: TextFormField(
                          maxLength: 3,
                          controller: cgpaController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: getProportionateScreenWidth(20),
                                      color: Colors.red),
                                  borderRadius: BorderRadius.circular(20)),
                              labelText: "CGPA"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "cannot be empty";
                            }
                            double? cgpa = double.tryParse(value);
                            if (cgpa == null || cgpa <= 1.5 || cgpa > 4.0) {
                              return "Invalid CGPA";
                            }
                            return null;
                          },
                          onChanged: (value) {},
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  const Text(
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
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "cannot be empty";
                          //   }
                          //   if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                          //     return "cannot be a number";
                          //   }
                          //   return null;
                          // },
                          onChanged: (value) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: GestureDetector(
                            onTap: () {
                              if (skillController.text.isNotEmpty &&
                                  skillController.text.length >= 3) {
                                addskills();
                              } else {
                                Utils().toastMessage(
                                    "lenght must be greater\nthen 3");
                              }
                            },
                            child: Icon(
                              Icons.add,
                              size: 30,
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(50),
                    width: getProportionateScreenWidth(375),
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
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    removeskill(
                                      '${skills[index]}',
                                    );
                                  },
                                  child: Icon(
                                    color: Colors.red,
                                    Icons.remove_circle,
                                    size: 30,
                                  )),
                            ],
                          );
                        })),
                  ),
                  const Text(
                    "Certification",
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
                          controller: certificateController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: getProportionateScreenWidth(20),
                                      color: Colors.red),
                                  borderRadius: BorderRadius.circular(20)),
                              labelText: "Specialization"),
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "cannot be empty";
                          //   }
                          //   if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                          //     return "cannot be a number";
                          //   }
                          //   return null;
                          // },
                          onChanged: (value) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: GestureDetector(
                            onTap: () {
                              if (certificateController.text.isNotEmpty &&
                                  certificateController.text.length >= 3) {
                                addcertification();
                              } else {
                                Utils().toastMessage(
                                    "lenght must be greater\nthen 3");
                              }
                            },
                            child: const Icon(
                              Icons.add,
                              size: 30,
                            )),
                      )
                    ],
                  ),
                  // new
                  SizedBox(
                    height: getProportionateScreenHeight(50),
                    width: getProportionateScreenWidth(380),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: certication.length,
                        itemBuilder: ((context, index) {
                          return Row(
                            children: [
                              Chip(
                                elevation: 20,
                                padding: const EdgeInsets.all(8),
                                backgroundColor: Colors.red,
                                // shadowColor: Colors.black,
                                label: Text(
                                  '${certication[index]}',
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    removecertification(
                                      '${certication[index]}',
                                    );
                                  },
                                  child: Icon(
                                    color: Colors.red,
                                    Icons.remove_circle,
                                    size: 30,
                                  )),
                            ],
                          );
                        })),
                  ),

                  SizedBox(
                    height: getProportionateScreenHeight(50),
                    width: getProportionateScreenWidth(350),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
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
                            "degprogram":
                                degreeProgramController.text.toString(),
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
                            Get.off(const SplashScreen());

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
                    height: getProportionateScreenHeight(2),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
