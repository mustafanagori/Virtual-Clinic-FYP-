import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorandpatient/core/utils.dart';
import 'package:doctorandpatient/models/doctor_model.dart';
import 'package:doctorandpatient/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../controller/doctors_controller.dart';
import '../../core/mytextfield.dart';
import '../../core/size_configuration.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({Key? key}) : super(key: key);

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  double _rating(List<dynamic>? rating) {
    RxList<double> doubleList = <double>[].obs;

    rating?.forEach((element) {
      doubleList.add(double.parse(element.toString()));
    });

    double sum = 0;
    for (double r in doubleList) {
      sum += r;
    }
    return sum / doubleList.length;
  }

  final currentUser = FirebaseAuth.instance.currentUser;
  TextEditingController speacialization = TextEditingController();
  DoctorController doctorController = Get.put(DoctorController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          "Doctor's Profile",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      // ignore: unnecessary_null_comparison
      body: GetBuilder<DoctorController>(
          init: DoctorController(),
          builder: (controller) {
            final doctorModel =
                doctorController.getDoctorById(currentUser!.uid);
            final rating = _rating(doctorModel.rating);

            return doctorModel == null
                ? const Center(child: CircularProgressIndicator())
                : Stack(
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(700),
                        child: Image.asset(
                          "Assets/TELEHEALTH-1.jpeg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            RatingBar.builder(
                              initialRating: rating,
                              minRating: 0,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              ignoreGestures: true,
                              onRatingUpdate: (rating) {
                                // print(rating);
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 40, left: 6),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Name",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 20),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10, left: 6),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    doctorModel.firstName.toString() +
                                        " " +
                                        doctorModel.lastName.toString(),
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
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 20),
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
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 20),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3, left: 6),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    doctorModel.contact,
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
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 20),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3, left: 6),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    doctorModel.gender,
                                    style: TextStyle(fontSize: 20),
                                  )),
                            ),
                            const Divider(),
                            Padding(
                              padding: EdgeInsets.only(top: 3, left: 6),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'PrNo',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 20),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3, left: 6),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    doctorModel.prno,
                                    style: TextStyle(fontSize: 20),
                                  )),
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 3, left: 6),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Speacialization',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 20),
                                      )),
                                ),
                                Spacer(),
                                addIcon(context, doctorModel)
                              ],
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(50),
                              child: Padding(
                                padding: EdgeInsets.only(top: 3, left: 6),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Text(
                                      doctorModel.spealization,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            SizedBox(
                              height: getProportionateScreenHeight(40),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: SizedBox(
                                height: getProportionateScreenHeight(50),
                                width: getProportionateScreenWidth(200),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      // side: BorderSide(
                                      //   width: getProportionateScreenWidth(1).0,
                                      //   color: Colors.blueAccent,
                                      // ),
                                      shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed: () {
                                      FirebaseAuth.instance
                                          .signOut()
                                          .then((value) {
                                        Get.off(Register());
                                      }).onError((error, stackTrace) {
                                        Utils().toastMessage(error.toString());
                                      });
                                    },
                                    child: const Text(
                                      "Logout",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
          }),
    );
  }

  IconButton addIcon(BuildContext context, DoctorModel doctorModel) {
    return IconButton(
      onPressed: () {
        Get.defaultDialog(
          title: "",
          content: SingleChildScrollView(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.red,
                    child: const Center(
                      child: Text("Add Specialization",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    height: getProportionateScreenHeight(50),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  MyTextField(
                    width: getProportionateScreenWidth(400),
                    hintText: " Add Specialization ",
                    controller: speacialization,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(5),
                        horizontal: getProportionateScreenWidth(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
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
                              if (speacialization.value.text.isNotEmpty) {
                                final temp = doctorModel.spealization.substring(
                                        0,
                                        doctorModel.spealization.length - 1) +
                                    ", " +
                                    speacialization.text +
                                    "]";
                                await FirebaseFirestore.instance
                                    .collection("doctors")
                                    .doc(currentUser!.uid)
                                    .update({"spealization": temp}).then(
                                        (value) {
                                  doctorController.fetchData();
                                  Utils().toastMessage("Specialization Added");
                                  speacialization.text = "";
                                  Navigator.pop(context);
                                }).onError((error, stackTrace) {
                                  Utils().toastMessage(error.toString());
                                });
                              } else {
                                Get.snackbar("Error", "Field is Empty");
                              }
                            },
                            child: Text(
                              " Add ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )),
                        // close
                        SizedBox(
                          width: getProportionateScreenWidth(50),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              // side: BorderSide(
                              //   width: getProportionateScreenWidth(1).0,
                              //   color: Colors.blueAccent,
                              // )
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              navigator?.pop(context);
                            },
                            child: const Text(
                              " Close ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      icon: const Icon(
        Icons.add_circle,
      ),
    );
  }
}

class DoctorController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  List<DoctorModel> _list = [];
  List<DoctorModel> get getList => _list;
  fetchData() async {
    await FirebaseFirestore.instance
        .collection("doctors")
        .get()
        .then((QuerySnapshot snapshot) {
      _list = [];
      for (var documents in snapshot.docs) {
        Map<String, dynamic> dataMap = documents.data() as Map<String, dynamic>;
        _list.insert(
            0, DoctorModel.fromMap(map: dataMap, userID: documents.id.trim()));
      }
    });
    update();
  }

  updateRating({required String doctorID, required List rating}) async {
    await FirebaseFirestore.instance
        .collection("doctors")
        .doc(doctorID)
        .update({"rating": rating});
    update();
    fetchData();
  }

  DoctorModel getDoctorById(String userID) {
    print(userID);
    return _list
        .firstWhere((element) => element.userID.trim() == userID.trim());
  }

  DoctorModel getCustomerByName(String firstName) {
    return _list
        .where((element) => element.firstName.trim() == firstName.trim())
        .first;
  }

  deleteCustomerData({required String userID}) async {
    await FirebaseFirestore.instance.collection("doctors").doc(userID).delete();
    _list.removeWhere(
      (element) => element.userID == userID,
    );
    update();
    fetchData();
  }
}













// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// import '../models/doctor_model.dart';

// class DoctorController extends GetxController {
//   @override
//   void onInit() {
//     super.onInit();
//     fetchData();
//   }

//   List<DoctorModel> _list = [];
//   List<DoctorModel> get getList => _list;
//   fetchData() async {
//     await FirebaseFirestore.instance
//         .collection("doctors")
//         .get()
//         .then((QuerySnapshot snapshot) {
//       _list = [];
//       for (var documents in snapshot.docs) {
//         Map<String, dynamic> dataMap = documents.data() as Map<String, dynamic>;
//         _list.insert(
//             0, DoctorModel.fromMap(map: dataMap, userID: documents.id.trim()));
//       }
//     });
//     update();
//   }

//   updateRating({required String doctorID, required List rating}) async {
    
//     await FirebaseFirestore.instance
//         .collection("doctors")
//         .doc(doctorID)
//         .update({"rating": rating});
//   }

//   DoctorModel getDoctorById(String userID) {
//     print(userID);
//     return _list
//         .firstWhere((element) => element.userID.trim() == userID.trim());
//   }

//   DoctorModel getCustomerByName(String firstName) {
//     return _list
//         .where((element) => element.firstName.trim() == firstName.trim())
//         .first;
//   }

//   deleteCustomerData({required String userID}) async {
//     await FirebaseFirestore.instance.collection("doctors").doc(userID).delete();
//     _list.removeWhere(
//       (element) => element.userID == userID,
//     );
//     update();
//   }
// }
