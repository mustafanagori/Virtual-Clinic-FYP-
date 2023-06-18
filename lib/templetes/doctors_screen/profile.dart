import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:doctorandpatient/signup.dart';
import 'package:doctorandpatient/core/utils.dart';
import 'package:doctorandpatient/models/doctor_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/doctors_controller.dart';
import '../../core/size_configuration.dart';
import '../../core/mytextfield.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({Key? key}) : super(key: key);

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  double _rating(List<dynamic>? rating) {
    List<double> doubleList = [];

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
  final doctorController = Get.put(DoctorController());

  @override
  Widget build(BuildContext context) {
    final doctorModel = doctorController.getDoctorById(currentUser!.uid);
    final rating = _rating(doctorModel.rating);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          "Doctor's Profile",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: doctorModel == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(700),
                  child: Image.asset(
                    "Assets/TELEHEALTH-1.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    RatingBar.builder(
                      initialRating: rating,
                      minRating: 0,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      ignoreGestures: true,
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    const Padding(
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
                            style: TextStyle(color: Colors.grey, fontSize: 20),
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
                            style: TextStyle(color: Colors.grey, fontSize: 20),
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
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 20),
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
                      padding: const EdgeInsets.symmetric(horizontal: 40),
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
                      ),
                    )
                  ],
                )
              ],
            ),
    );
  }

  IconButton addIcon(BuildContext context, DoctorModel doctorModel) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => SizedBox(
              height: getProportionateScreenHeight(400),
              width: getProportionateScreenWidth(500),
              child: Column(
                children: [
                  Container(
                    color: Colors.red,
                    child: Center(
                      child: Text("Add Speacialzation",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    height: getProportionateScreenHeight(50),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  MyTextField(
                    width: getProportionateScreenWidth(600),
                    hintText: " Add Spealization ",
                    controller: speacialization,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(5),
                        horizontal: getProportionateScreenWidth(20)),
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
                          final temp = doctorModel.spealization.substring(
                                  0, doctorModel.spealization.length - 1) +
                              ", " +
                              speacialization.text +
                              "]";
                          await FirebaseFirestore.instance
                              .collection("doctors")
                              .doc(currentUser!.uid)
                              .update({"spealization": temp}).then((value) {
                            doctorController.fetchData();
                            Utils().toastMessage("Speacialization Added");
                            speacialization.text = "";
                            Navigator.pop(context);
                          }).onError((error, stackTrace) {
                            Utils().toastMessage(error.toString());
                          });
                        },
                        child: Text(
                          " Add ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),
                  )
                ],
              )),
        );
      },
      icon: Icon(
        Icons.add_circle,
      ),
    );
  }
}

        
        // SafeArea(
        //     child: Container(
        //   decoration: BoxDecoration(
        //       image: DecorationImage(
        //           fit: BoxFit.cover,
        //           colorFilter: new ColorFilter.mode(
        //               Colors.black.withOpacity(0.4), BlendMode.dstATop),
        //           image: AssetImage("Assets/TELEHEALTH-1.jpeg"))),
        //   child: Column(children: [
        //     Center(
        //       child: SizedBox(
        //         height: getProportionateScreenHeight(500),
        //         width: getProportionateScreenWidth(500),
        //         child: CircleAvatar(
        //           child: Image.asset(
        //             'Assets/Ellipse.png',
        //             scale: 4,
        //           ),
        //         ),
        //       ),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.only(top: 40, left: 6),
        //       child: Align(
        //           alignment: Alignment.centerLeft,
        //           child: Text(
        //             "Name",
        //             style: TextStyle(color: Colors.grey, fontSize: 20),
        //           )),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.only(top: 10, left: 6),
        //       child: Align(
        //           alignment: Alignment.centerLeft,
        //           child: Text(
        //             doctorModel.firstName.toString() +
        //                 " " +
        //                 doctorModel.lastName.toString(),
        //             style: TextStyle(fontSize: 20),
        //           )),
        //     ),
        //     Divider(),
        //     Padding(
        //       padding: EdgeInsets.only(top: 10, left: 6),
        //       child: Align(
        //           alignment: Alignment.centerLeft,
        //           child: Text(
        //             'Email',
        //             style: TextStyle(color: Colors.grey, fontSize: 20),
        //           )),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.only(top: 10, left: 6),
        //       child: Align(
        //           alignment: Alignment.centerLeft,
        //           child: Text(
        //             currentUser!.email.toString(),
        //             style: TextStyle(fontSize: 20),
        //           )),
        //     ),
        //     Divider(),
        //     Padding(
        //       padding: EdgeInsets.only(top: 3, left: 6),
        //       child: Align(
        //           alignment: Alignment.centerLeft,
        //           child: Text(
        //             'Phone Number',
        //             style: TextStyle(color: Colors.grey, fontSize: 20),
        //           )),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.only(top: 3, left: 6),
        //       child: Align(
        //           alignment: Alignment.centerLeft,
        //           child: Text(
        //             doctorModel.contact,
        //             style: TextStyle(fontSize: 20),
        //           )),
        //     ),
        //     Divider(),
        //     Padding(
        //       padding: EdgeInsets.only(top: 3, left: 6),
        //       child: Align(
        //           alignment: Alignment.centerLeft,
        //           child: Text(
        //             'Gender',
        //             style: TextStyle(color: Colors.grey, fontSize: 20),
        //           )),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.only(top: 3, left: 6),
        //       child: Align(
        //           alignment: Alignment.centerLeft,
        //           child: Text(
        //             doctorModel.gender,
        //             style: TextStyle(fontSize: 20),
        //           )),
        //     ),
        //     Divider(),
        //     SizedBox(
        //       height: getProportionateScreenHeight(4),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.only(top: 3, left: 6),
        //       child: Align(
        //           alignment: Alignment.centerLeft,
        //           child: Text(
        //             'Speacialization',
        //             style: TextStyle(color: Colors.grey, fontSize: 20),
        //           )),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.only(top: 3, left: 6),
        //       child: Align(
        //           alignment: Alignment.centerLeft,
        //           child: ListView(
        //             scrollDirection: Axis.horizontal,
        //             children: [
        //               Text(
        //                 doctorModel.spealization,
        //                 style: TextStyle(fontSize: 20),
        //               ),
        //               Spacer(),
        //               Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: IconButton(
        //                   onPressed: () {
        //                     showModalBottomSheet(
        //                       context: context,
        //                       builder: (context) => SizedBox(
        //                           height: getProportionateScreenHeight(400),
        //                           width: getProportionateScreenWidth(500),
        //                           child: Column(
        //                             children: [
        //                               Container(
        //                                 color: Colors.red,
        //                                 child: Center(
        //                                   child: Text("Add Speacialzation",
        //                                       style: TextStyle(
        //                                           fontSize: 24,
        //                                           fontWeight: FontWeight.bold,
        //                                           color: Colors.white)),
        //                                 ),
        //                                 height:
        //                                     getProportionateScreenHeight(50),
        //                               ),
        //                               SizedBox(
        //                                 height:
        //                                     getProportionateScreenHeight(10),
        //                               ),
        //                               MyTextField(
        //                                 leading: Icon(Icons.add),
        //                                 width: getProportionateScreenWidth(600),
        //                                 hintText: " Add Spealization ",
        //                                 controller: speacialization,
        //                               ),
        //                               Padding(
        //                                 padding: EdgeInsets.symmetric(
        //                                     vertical:
        //                                         getProportionateScreenHeight(5),
        //                                     horizontal:
        //                                         getProportionateScreenWidth(
        //                                             20)),
        //                                 child: ElevatedButton(
        //                                     style: ElevatedButton.styleFrom(
        //                                       primary: Colors.red,
        //                                       // side: BorderSide(
        //                                       //   width: getProportionateScreenWidth(1).0,
        //                                       //   color: Colors.blueAccent,
        //                                       // ),
        //                                       shape: new RoundedRectangleBorder(
        //                                         borderRadius:
        //                                             new BorderRadius.circular(
        //                                                 20),
        //                                       ),
        //                                     ),
        //                                     onPressed: () async {
        //                                       final temp = doctorModel
        //                                               .spealization
        //                                               .substring(
        //                                                   0,
        //                                                   doctorModel
        //                                                           .spealization
        //                                                           .length -
        //                                                       1) +
        //                                           ", " +
        //                                           speacialization.text +
        //                                           "]";
        //                                       await FirebaseFirestore.instance
        //                                           .collection("doctors")
        //                                           .doc(currentUser!.uid)
        //                                           .update({
        //                                         "spealization": temp
        //                                       }).then((value) {
        //                                         doctorController.fetchData();
        //                                         Utils().toastMessage(
        //                                             "Speacialization Added");
        //                                         speacialization.text = "";
        //                                         Navigator.pop(context);
        //                                       }).onError((error, stackTrace) {
        //                                         Utils().toastMessage(
        //                                             error.toString());
        //                                       });
        //                                     },
        //                                     child: Text(
        //                                       " Add ",
        //                                       style: TextStyle(
        //                                           color: Colors.white,
        //                                           fontWeight: FontWeight.bold,
        //                                           fontSize: 20),
        //                                     )),
        //                               )
        //                             ],
        //                           )),
        //                     );
        //                   },
        //                   icon: Icon(
        //                     Icons.add_circle,
        //                   ),
        //                 ),
        //               )
        //             ],
        //           )),
        //     ),
        //     Divider(),
        //     SizedBox(
        //       height: getProportionateScreenHeight(40),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 40),
        //       child: ElevatedButton(
        //           style: ElevatedButton.styleFrom(
        //             primary: Colors.red,
        //             // side: BorderSide(
        //             //   width: getProportionateScreenWidth(1).0,
        //             //   color: Colors.blueAccent,
        //             // ),
        //             shape: new RoundedRectangleBorder(
        //               borderRadius: new BorderRadius.circular(20),
        //             ),
        //           ),
        //           onPressed: () {
        //             FirebaseAuth.instance.signOut().then((value) {
        //               Get.off(Register());
        //             }).onError((error, stackTrace) {
        //               Utils().toastMessage(error.toString());
        //             });
        //           },
        //           child: Text(
        //             "Logout",
        //             style: TextStyle(
        //                 color: Colors.white,
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: 20),
        //           )),
        //     )
        //   ]),
        // ))