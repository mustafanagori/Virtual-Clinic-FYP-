// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:doctorandpatient/core/utils.dart';

// import 'package:firebase_auth/firebase_auth.dart';
// // ignore: unused_import
// import 'package:doctorandpatient/templetes/doctors_screen/doctorhome.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';

// import '../../controller/doctors_controller.dart';
// import '../../helper/size_configuration.dart';
// import '../../splashscreen.dart';

// class pi extends StatefulWidget {
//   const pi({super.key});

//   @override
//   State<pi> createState() => _piState();
// }

// class _piState extends State<pi> {
//   bool loading = false;
//   final currentUserid = FirebaseAuth.instance.currentUser!.uid;
//   //SkillsController
//   TextEditingController skillController = TextEditingController();
//   List skills = [];
//   List certication = [];

//   String? gender;
//   void addskills() {
//     String skill = skillController.text.toString();
//     setState(() {
//       skills.add(skill);
//     });
//   }

// // cetfications
//   TextEditingController instituteController = TextEditingController();
//   void addcertification() {
//     String instituteName = instituteController.text.toString();

//     setState(() {
//       certication.add(instituteName);
//     });
//   }

//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final contactController = TextEditingController();
//   final prnoController = TextEditingController();
//   final cnicController = TextEditingController();
//   final emailController = TextEditingController();
//   final universityNameController = TextEditingController();
//   final degreeProgramController = TextEditingController();
//   final passyearController = TextEditingController();
//   final cgpaController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           leading: GestureDetector(
//               onTap: () {
//                 //  Get.off(());
//               },
//               child: Icon(Icons.arrow_back)),
//           backgroundColor: Colors.red,
//           title: Text('Dr Verification Form')),
//       body: SingleChildScrollView(
//         child: Container(
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     fit: BoxFit.cover,
//                     colorFilter: new ColorFilter.mode(
//                         Colors.black.withOpacity(0.4), BlendMode.dstATop),
//                     image: AssetImage("Assets/pexels-pixabay-40568.jpeg"))),
//             child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: getProportionateScreenHeight(10),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Container(
//                     width: getProportionateScreenWidth(80),
//                     child: TextFormField(
//                       controller: firstNameController,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   width: getProportionateScreenWidth(1),
//                                   color: Colors.red),
//                               borderRadius: BorderRadius.circular(2)),
//                           labelText: "First Name"),
//                     ),
//                   ),
//                   Container(
//                     width: getProportionateScreenWidth(1),
//                     child: TextFormField(
//                       controller: lastNameController,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   width: getProportionateScreenWidth(4),
//                                   color: Colors.red),
//                               borderRadius: BorderRadius.circular(2)),
//                           labelText: "Last Name"),
//                     ),
//                   ),
//                 ],
//               ),

//               // .
//               SizedBox(
//                 height: getProportionateScreenHeight(2),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Container(
//                     width: getProportionateScreenWidth(1),
//                     child: TextFormField(
//                       keyboardType: TextInputType.phone,
//                       controller: contactController,
//                       maxLength: 11,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   width: getProportionateScreenWidth(1),
//                                   color: Colors.red),
//                               borderRadius: BorderRadius.circular(20)),
//                           labelText: "Contact No"),
//                     ),
//                   ),
//                   Container(
//                     width: getProportionateScreenWidth(1),
//                     child: TextFormField(
//                       keyboardType: TextInputType.number,
//                       controller: prnoController,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   width: getProportionateScreenWidth(2),
//                                   color: Colors.red),
//                               borderRadius: BorderRadius.circular(1)),
//                           labelText: "PRNO#"),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: getProportionateScreenHeight(1),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Container(
//                     width: getProportionateScreenWidth(1),
//                     child: TextFormField(
//                       keyboardType: TextInputType.number,
//                       maxLength: 13,
//                       controller: cnicController,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   width: getProportionateScreenWidth(1),
//                                   color: Colors.red),
//                               borderRadius: BorderRadius.circular(20)),
//                           labelText: "CNIC NO"),
//                     ),
//                   ),
//                 ],
//               ),
//               Column(
//                 children: [
//                   RadioListTile(
//                     title: Text("Male"),
//                     value: "male",
//                     groupValue: gender,
//                     onChanged: (value) {
//                       setState(() {
//                         gender = value.toString();
//                       });
//                     },
//                   ),
//                   RadioListTile(
//                     title: Text("Female"),
//                     value: "female",
//                     groupValue: gender,
//                     onChanged: (value) {
//                       setState(() {
//                         gender = value.toString();
//                       });
//                     },
//                   ),
//                   // RadioListTile(
//                   //   title: Text("Other"),
//                   //   value: "other",
//                   //   groupValue: gender,
//                   //   onChanged: (value) {
//                   //     setState(() {
//                   //       gender = value.toString();
//                   //     });
//                   //   },
//                   // ),
//                 ],
//               ),
//               Text(
//                 "Education",
//                 style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: getProportionateScreenHeight(1),
//               ),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Container(
//                     width: getProportionateScreenWidth(2),
//                     child: TextFormField(
//                       controller: universityNameController,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   width: getProportionateScreenWidth(2),
//                                   color: Colors.red),
//                               borderRadius: BorderRadius.circular(2)),
//                           labelText: "University Name"),
//                     ),
//                   ),
//                   Container(
//                     width: getProportionateScreenWidth(2),
//                     child: TextFormField(
//                       controller: degreeProgramController,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   width: getProportionateScreenWidth(2),
//                                   color: Colors.red),
//                               borderRadius: BorderRadius.circular(2)),
//                           labelText: "Degree Program"),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: getProportionateScreenHeight(1),
//               ),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Container(
//                     width: getProportionateScreenWidth(2),
//                     child: TextFormField(
//                       keyboardType: TextInputType.number,
//                       controller: passyearController,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   width: getProportionateScreenWidth(1),
//                                   color: Colors.red),
//                               borderRadius: BorderRadius.circular(2)),
//                           labelText: "Years of Passing"),
//                     ),
//                   ),
//                   Container(
//                     width: getProportionateScreenWidth(2),
//                     child: TextFormField(
//                       keyboardType: TextInputType.number,
//                       controller: cgpaController,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   width: getProportionateScreenWidth(2),
//                                   color: Colors.red),
//                               borderRadius: BorderRadius.circular(2)),
//                           labelText: "CGPA"),
//                     ),
//                   ),
//                 ],
//               ),

//               SizedBox(
//                 height: getProportionateScreenHeight(1),
//               ),

//               Text(
//                 "Add Skills",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: getProportionateScreenHeight(1),
//               ),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Container(
//                     width: getProportionateScreenWidth(1),
//                     child: TextFormField(
//                       controller: skillController,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   width: getProportionateScreenWidth(2),
//                                   color: Colors.red),
//                               borderRadius: BorderRadius.circular(2)),
//                           labelText: "Add Skills"),
//                     ),
//                   ),
//                   GestureDetector(
//                       onTap: () {
//                         if (skillController.text.isNotEmpty) {
//                           addskills();
//                         }
//                       },
//                       child: Icon(Icons.add))
//                 ],
//               ),

//               SizedBox(
//                 height: getProportionateScreenHeight(1),
//               ),
//               Container(
//                 height: getProportionateScreenHeight(2),
//                 width: getProportionateScreenWidth(2),
//                 // color: Colors.grey.shade300,
//                 child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: skills.length,
//                     itemBuilder: ((context, index) {
//                       return Row(
//                         children: [
//                           Chip(
//                             elevation: 20,
//                             padding: EdgeInsets.all(8),
//                             backgroundColor: Colors.red,
//                             // shadowColor: Colors.black,
//                             label: Text(
//                               '${skills[index]}',
//                               style:
//                                   TextStyle(fontSize: 20, color: Colors.white),
//                             ),
//                           ),
//                         ],
//                       );
//                     })),
//               ),
//               Text(
//                 "Certification",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: getProportionateScreenHeight(1),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Container(
//                     width: getProportionateScreenWidth(3),
//                     child: TextFormField(
//                       controller: instituteController,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   width: getProportionateScreenWidth(3),
//                                   color: Colors.red),
//                               borderRadius: BorderRadius.circular(2)),
//                           labelText: "Specialization"),
//                     ),
//                   ),
//                   GestureDetector(
//                       onTap: () {
//                         addcertification();
//                       },
//                       child: Icon(Icons.add))
//                 ],
//               ),
//               Container(
//                 height: setHeight(60),
//                 width: getProportionateScreenWidth(4),
//                 // color: Colors.grey.shade200,
//                 child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: certication.length,
//                     itemBuilder: ((context, index) {
//                       return Align(
//                         alignment: Alignment.centerLeft,
//                         child: Chip(
//                           elevation: 20,
//                           padding: EdgeInsets.all(8),
//                           backgroundColor: Colors.red,
//                           // shadowColor: Colors.black,
//                           label: Text(
//                             '${certication[index]}',
//                             style: TextStyle(fontSize: 20, color: Colors.white),
//                           ),
//                         ),
//                       );
//                     })),
//               ),

//               Container(
//                 height: getProportionateScreenHeight(2),
//                 width: getProportionateScreenWidth(2),
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
//                   onPressed: () async {
//                     setState(() {
//                       loading = true;
//                     });
//                     await FirebaseFirestore.instance
//                         .collection("doctors")
//                         .doc(FirebaseAuth.instance.currentUser!.uid)
//                         .set({
//                       "firstName": firstNameController.text.toString(),
//                       "lastName": lastNameController.text.toString(),
//                       "contact": contactController.text.toString(),
//                       "prno": prnoController.text.toString(),
//                       "cnic": cnicController.text.toString(),
//                       "gender": gender.toString(),
//                       "uniname": universityNameController.text.toString(),
//                       "degprogram": degreeProgramController.text.toString(),
//                       "passyear": passyearController.text.toString(),
//                       "cgpa": cgpaController.text.toString(),
//                       "skills": skills.toString(),
//                       "spealization": certication.toString(),
//                     }).then((value) async {
//                       Utils().toastMessage("Data Added");
//                       await FirebaseFirestore.instance
//                           .collection("users")
//                           .doc(FirebaseAuth.instance.currentUser!.uid)
//                           .update({
//                         "isVerified": true,
//                       });
//                       Get.put(DoctorController());
//                       Get.off(splashScreen());

//                       setState(() {
//                         loading = false;
//                       });
//                     }).onError((error, stackTrace) {
//                       Utils().toastMessage(error.toString());
//                       setState(() {
//                         loading = false;
//                       });
//                     });
//                   },
//                   child: Text(
//                     'Submit',
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: getProportionateScreenHeight(2),
//               )

//               // Center(
//               //   child: Container(
//               //     width: getProportionateScreenWidth(300),
//               //     child: ElevatedButton(
//               //         style: ElevatedButton.styleFrom(
//               //             primary: Colors.grey.shade50,
//               //             padding:
//               //                 EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//               //             textStyle:
//               //                 TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//               //         onPressed: (() {
//               //           showDialog(
//               //               context: context,
//               //               builder: (BuildContext context) {
//               //                 return Dialog(
//               //                   shape: RoundedRectangleBorder(
//               //                       borderRadius: BorderRadius.circular(
//               //                           20.0)), //this right here
//               //                   child: Container(
//               //                     height: getProportionateScreenHeight(500),
//               //                     child: Padding(
//               //                       padding: const EdgeInsets.all(12.0),
//               //                       child: Column(
//               //                         mainAxisAlignment: MainAxisAlignment.center,
//               //                         crossAxisAlignment: CrossAxisAlignment.start,
//               //                         children: [
//               //                           Container(
//               //                               height: getProportionateScreenHeight(50),
//               //                               color: Colors.red,
//               //                               child: Center(
//               //                                   child: Text(
//               //                                 "Perosnal Info",
//               //                                 style: TextStyle(
//               //                                     color: Colors.white,
//               //                                     fontWeight: FontWeight.bold,
//               //                                     fontSize: 30),
//               //                               ))),
//               //                           SizedBox(
//               //                             height: getProportionateScreenHeight(20),
//               //                           ),
//               //                           TextFormField(
//               //                             controller: prnoController,
//               //                             decoration: InputDecoration(
//               //                                 border: OutlineInputBorder(
//               //                                     borderSide: BorderSide(
//               //                                         width: getProportionateScreenWidth(3), color: Colors.red),
//               //                                     borderRadius:
//               //                                         BorderRadius.circular(20)),
//               //                                 labelText: "PRNO#"),
//               //                           ),
//               //                           SizedBox(
//               //                             height: getProportionateScreenHeight(10),
//               //                           ),
//               //                           TextFormField(
//               //                             controller: firstNameController,
//               //                             decoration: InputDecoration(
//               //                                 border: OutlineInputBorder(
//               //                                     borderSide: BorderSide(
//               //                                         width: getProportionateScreenWidth(3), color: Colors.red),
//               //                                     borderRadius:
//               //                                         BorderRadius.circular(20)),
//               //                                 labelText: "First Name"),
//               //                           ),
//               //                           SizedBox(
//               //                             height: getProportionateScreenHeight(10),
//               //                           ),
//               //                           TextFormField(
//               //                             controller: lastNameController,
//               //                             decoration: InputDecoration(
//               //                                 border: OutlineInputBorder(
//               //                                     borderSide: BorderSide(
//               //                                         width: getProportionateScreenWidth(3), color: Colors.red),
//               //                                     borderRadius:
//               //                                         BorderRadius.circular(20)),
//               //                                 labelText: "Last Name"),
//               //                           ),
//               //                           SizedBox(
//               //                             height: getProportionateScreenHeight(10),
//               //                           ),
//               //                           TextFormField(
//               //                             controller: contactNoController,
//               //                             decoration: InputDecoration(
//               //                                 border: OutlineInputBorder(
//               //                                     borderSide: BorderSide(
//               //                                         width: getProportionateScreenWidth(3), color: Colors.red),
//               //                                     borderRadius:
//               //                                         BorderRadius.circular(20)),
//               //                                 labelText: "Contact No"),
//               //                           ),
//               //                           SizedBox(
//               //                             height: getProportionateScreenHeight(20),
//               //                           ),
//               //                           Center(
//               //                             child: Container(
//               //                               height: getProportionateScreenHeight(50),
//               //                               width: getProportionateScreenWidth(300),
//               //                               //   width: getProportionateScreenWidth(15)0,
//               //                               child: ElevatedButton(
//               //                                 style: ElevatedButton.styleFrom(
//               //                                   primary: Colors.red,
//               //                                   // side: BorderSide(
//               //                                   //   width: getProportionateScreenWidth(1).0,
//               //                                   //   color: Colors.blueAccent,
//               //                                   // ),
//               //                                   shape: new RoundedRectangleBorder(
//               //                                     borderRadius:
//               //                                         new BorderRadius.circular(20),
//               //                                   ),
//               //                                 ),
//               //                                 onPressed: () {},
//               //                                 child: Text(
//               //                                   'Submit',
//               //                                   style: TextStyle(
//               //                                       color: Colors.white,
//               //                                       fontSize: 20),
//               //                                 ),
//               //                               ),
//               //                             ),
//               //                           ),
//               //                         ],
//               //                       ),
//               //                     ),
//               //                   ),
//               //                 );
//               //               });
//               //         }),
//               //         child: Text("Add Personal")),
//               //   ),
//               // ),
//               // SizedBox(
//               //   height: getProportionateScreenHeight(20),
//               // ),
//               // Center(
//               //   child: Container(
//               //     width: getProportionateScreenWidth(300),
//               //     child: ElevatedButton(
//               //         style: ElevatedButton.styleFrom(
//               //             primary: Colors.grey.shade500,
//               //             padding:
//               //                 EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//               //             textStyle:
//               //                 TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//               //         onPressed: (() {
//               //           showDialog(
//               //               context: context,
//               //               builder: (BuildContext context) {
//               //                 return Dialog(
//               //                   shape: RoundedRectangleBorder(
//               //                       borderRadius: BorderRadius.circular(
//               //                           20.0)), //this right here
//               //                   child: Container(
//               //                     height: getProportionateScreenHeight(500),
//               //                     child: Padding(
//               //                       padding: const EdgeInsets.all(12.0),
//               //                       child: Column(
//               //                         mainAxisAlignment: MainAxisAlignment.center,
//               //                         crossAxisAlignment: CrossAxisAlignment.start,
//               //                         children: [
//               //                           Container(
//               //                               height: getProportionateScreenHeight(50),
//               //                               color: Colors.red,
//               //                               child: Center(
//               //                                   child: Text(
//               //                                 "Education Info",
//               //                                 style: TextStyle(
//               //                                     color: Colors.white,
//               //                                     fontWeight: FontWeight.bold,
//               //                                     fontSize: 30),
//               //                               ))),
//               //                           SizedBox(
//               //                             height: getProportionateScreenHeight(20),
//               //                           ),
//               //                           TextFormField(
//               //                             decoration: InputDecoration(
//               //                                 border: OutlineInputBorder(
//               //                                     borderSide: BorderSide(
//               //                                         width: getProportionateScreenWidth(3), color: Colors.red),
//               //                                     borderRadius:
//               //                                         BorderRadius.circular(20)),
//               //                                 labelText: "University Name"),
//               //                           ),
//               //                           SizedBox(
//               //                             height: getProportionateScreenHeight(10),
//               //                           ),
//               //                           TextFormField(
//               //                             decoration: InputDecoration(
//               //                                 border: OutlineInputBorder(
//               //                                     borderSide: BorderSide(
//               //                                         width: getProportionateScreenWidth(3), color: Colors.red),
//               //                                     borderRadius:
//               //                                         BorderRadius.circular(20)),
//               //                                 labelText: "Total Marks"),
//               //                           ),
//               //                           SizedBox(
//               //                             height: getProportionateScreenHeight(10),
//               //                           ),
//               //                           TextFormField(
//               //                             decoration: InputDecoration(
//               //                                 border: OutlineInputBorder(
//               //                                     borderSide: BorderSide(
//               //                                         width: getProportionateScreenWidth(3), color: Colors.red),
//               //                                     borderRadius:
//               //                                         BorderRadius.circular(20)),
//               //                                 labelText: "Obtained Marks"),
//               //                           ),
//               //                           SizedBox(
//               //                             height: getProportionateScreenHeight(10),
//               //                           ),
//               //                           TextFormField(
//               //                             decoration: InputDecoration(
//               //                                 border: OutlineInputBorder(
//               //                                     borderSide: BorderSide(
//               //                                         width: getProportionateScreenWidth(3), color: Colors.red),
//               //                                     borderRadius:
//               //                                         BorderRadius.circular(20)),
//               //                                 labelText: "Grades"),
//               //                           ),
//               //                           SizedBox(
//               //                             height: getProportionateScreenHeight(20),
//               //                           ),
//               //                           Center(
//               //                             child: Container(
//               //                               height: getProportionateScreenHeight(50),
//               //                               width: getProportionateScreenWidth(300),
//               //                               //   width: getProportionateScreenWidth(15)0,
//               //                               child: ElevatedButton(
//               //                                 style: ElevatedButton.styleFrom(
//               //                                   primary: Colors.red,
//               //                                   // side: BorderSide(
//               //                                   //   width: getProportionateScreenWidth(1).0,
//               //                                   //   color: Colors.blueAccent,
//               //                                   // ),
//               //                                   shape: new RoundedRectangleBorder(
//               //                                     borderRadius:
//               //                                         new BorderRadius.circular(20),
//               //                                   ),
//               //                                 ),
//               //                                 onPressed: () {},
//               //                                 child: Text(
//               //                                   'Submit',
//               //                                   style: TextStyle(
//               //                                       color: Colors.white,
//               //                                       fontSize: 20),
//               //                                 ),
//               //                               ),
//               //                             ),
//               //                           ),
//               //                         ],
//               //                       ),
//               //                     ),
//               //                   ),
//               //                 );
//               //               });
//               //         }),
//               //         child: Text("Add Education")),
//               //   ),
//               // ),
//               // SizedBox(
//               //   height: getProportionateScreenHeight(20),
//               // ),
//               // Center(
//               //   child: Container(
//               //     width: getProportionateScreenWidth(300),
//               //     child: ElevatedButton(
//               //         style: ElevatedButton.styleFrom(
//               //             primary: Colors.grey.shade500,
//               //             padding:
//               //                 EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//               //             textStyle:
//               //                 TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//               //         onPressed: (() {
//               //           showDialog(
//               //               context: context,
//               //               builder: (BuildContext context) {
//               //                 return Dialog(
//               //                   shape: RoundedRectangleBorder(
//               //                       borderRadius: BorderRadius.circular(
//               //                           20.0)), //this right here
//               //                   child: Container(
//               //                     height: getProportionateScreenHeight(500),
//               //                     child: Padding(
//               //                       padding: const EdgeInsets.all(12.0),
//               //                       child: Column(
//               //                         mainAxisAlignment: MainAxisAlignment.center,
//               //                         crossAxisAlignment: CrossAxisAlignment.start,
//               //                         children: [
//               //                           Container(
//               //                               height: getProportionateScreenHeight(50),
//               //                               color: Colors.red,
//               //                               child: Center(
//               //                                   child: Text(
//               //                                 "Profession",
//               //                                 style: TextStyle(
//               //                                     color: Colors.white,
//               //                                     fontWeight: FontWeight.bold,
//               //                                     fontSize: 30),
//               //                               ))),
//               //                           SizedBox(
//               //                             height: getProportionateScreenHeight(20),
//               //                           ),
//               //                           TextFormField(
//               //                             decoration: InputDecoration(
//               //                                 border: OutlineInputBorder(
//               //                                     borderSide: BorderSide(
//               //                                         width: getProportionateScreenWidth(3), color: Colors.red),
//               //                                     borderRadius:
//               //                                         BorderRadius.circular(20)),
//               //                                 labelText: "Enter your Doctor Type"),
//               //                           ),
//               //                           SizedBox(
//               //                             height: getProportionateScreenHeight(10),
//               //                           ),
//               //                           TextFormField(
//               //                             decoration: InputDecoration(
//               //                                 border: OutlineInputBorder(
//               //                                     borderSide: BorderSide(
//               //                                         width: getProportionateScreenWidth(3), color: Colors.red),
//               //                                     borderRadius:
//               //                                         BorderRadius.circular(20)),
//               //                                 labelText: "Enter your Doctor Type"),
//               //                           ),
//               //                           SizedBox(
//               //                             height: getProportionateScreenHeight(10),
//               //                           ),
//               //                           TextFormField(
//               //                             decoration: InputDecoration(
//               //                                 border: OutlineInputBorder(
//               //                                     borderSide: BorderSide(
//               //                                         width: getProportionateScreenWidth(3), color: Colors.red),
//               //                                     borderRadius:
//               //                                         BorderRadius.circular(20)),
//               //                                 labelText: "Enter your Doctor Type"),
//               //                           ),
//               //                           SizedBox(
//               //                             height: getProportionateScreenHeight(10),
//               //                           ),
//               //                           TextFormField(
//               //                             decoration: InputDecoration(
//               //                                 border: OutlineInputBorder(
//               //                                     borderSide: BorderSide(
//               //                                         width: getProportionateScreenWidth(3), color: Colors.red),
//               //                                     borderRadius:
//               //                                         BorderRadius.circular(20)),
//               //                                 labelText: "Enter your Doctor Type"),
//               //                           ),
//               //                           SizedBox(
//               //                             height: getProportionateScreenHeight(20),
//               //                           ),
//               //                           Center(
//               //                             child: Container(
//               //                               height: getProportionateScreenHeight(50),
//               //                               width: getProportionateScreenWidth(300),
//               //                               //   width: getProportionateScreenWidth(15)0,
//               //                               child: ElevatedButton(
//               //                                 style: ElevatedButton.styleFrom(
//               //                                   primary: Colors.red,
//               //                                   // side: BorderSide(
//               //                                   //   width: getProportionateScreenWidth(1).0,
//               //                                   //   color: Colors.blueAccent,
//               //                                   // ),
//               //                                   shape: new RoundedRectangleBorder(
//               //                                     borderRadius:
//               //                                         new BorderRadius.circular(20),
//               //                                   ),
//               //                                 ),
//               //                                 onPressed: () {},
//               //                                 child: Text(
//               //                                   'Submit',
//               //                                   style: TextStyle(
//               //                                       color: Colors.white,
//               //                                       fontSize: 20),
//               //                                 ),
//               //                               ),
//               //                             ),
//               //                           ),
//               //                         ],
//               //                       ),
//               //                     ),
//               //                   ),
//               //                 );
//               //               });
//               //         }),
//               //         child: Text("Add Profession")),
//               //   ),
//               // ),
//               // SizedBox(
//               //   height: getProportionateScreenHeight(20),
//               // ),
//               // Center(
//               //   child: Container(
//               //     width: getProportionateScreenWidth(300),
//               //     child: ElevatedButton(
//               //         style: ElevatedButton.styleFrom(
//               //             primary: Colors.grey.shade500,
//               //             padding:
//               //                 EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//               //             textStyle:
//               //                 TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//               //         onPressed: (() {
//               //           showDialog(
//               //               context: context,
//               //               builder: (BuildContext context) {
//               //                 return Dialog(
//               //                   shape: RoundedRectangleBorder(
//               //                       borderRadius: BorderRadius.circular(
//               //                           20.0)), //this right here
//               //                   child: Container(
//               //                     height: getProportionateScreenHeight(500),
//               //                     child: Padding(
//               //                       padding: const EdgeInsets.all(12.0),
//               //                       child: Column(
//               //                         mainAxisAlignment: MainAxisAlignment.center,
//               //                         crossAxisAlignment: CrossAxisAlignment.start,
//               //                         children: [
//               //                           Container(
//               //                               height: getProportionateScreenHeight(50),
//               //                               color: Colors.red,
//               //                               child: Center(
//               //                                   child: Text(
//               //                                 "Skills",
//               //                                 style: TextStyle(
//               //                                     color: Colors.white,
//               //                                     fontWeight: FontWeight.bold,
//               //                                     fontSize: 30),
//               //                               ))),
//               //                           SizedBox(
//               //                             height: getProportionateScreenHeight(20),
//               //                           ),
//               //                           TextFormField(
//               //                             decoration: InputDecoration(
//               //                                 border: OutlineInputBorder(
//               //                                     borderSide: BorderSide(
//               //                                         width: getProportionateScreenWidth(3), color: Colors.red),
//               //                                     borderRadius:
//               //                                         BorderRadius.circular(20)),
//               //                                 labelText: "Enter your Doctor Type"),
//               //                           ),
//               //                           SizedBox(
//               //                             height: getProportionateScreenHeight(10),
//               //                           ),
//               //                           TextFormField(
//               //                             decoration: InputDecoration(
//               //                                 border: OutlineInputBorder(
//               //                                     borderSide: BorderSide(
//               //                                         width: getProportionateScreenWidth(3), color: Colors.red),
//               //                                     borderRadius:
//               //                                         BorderRadius.circular(20)),
//               //                                 labelText: "Enter your Doctor Type"),
//               //                           ),
//               //                           SizedBox(
//               //                             height: getProportionateScreenHeight(10),
//               //                           ),
//               //                           Expanded(child: CategryScreen()),
//               //                           Center(
//               //                             child: Container(
//               //                               height: getProportionateScreenHeight(50),
//               //                               width: getProportionateScreenWidth(300),
//               //                               //   width: getProportionateScreenWidth(15)0,
//               //                               child: ElevatedButton(
//               //                                 style: ElevatedButton.styleFrom(
//               //                                   primary: Colors.red,
//               //                                   // side: BorderSide(
//               //                                   //   width: getProportionateScreenWidth(1).0,
//               //                                   //   color: Colors.blueAccent,
//               //                                   // ),
//               //                                   shape: new RoundedRectangleBorder(
//               //                                     borderRadius:
//               //                                         new BorderRadius.circular(20),
//               //                                   ),
//               //                                 ),
//               //                                 onPressed: () {},
//               //                                 child: Text(
//               //                                   'Submit',
//               //                                   style: TextStyle(
//               //                                       color: Colors.white,
//               //                                       fontSize: 20),
//               //                                 ),
//               //                               ),
//               //                             ),
//               //                           ),
//               //                         ],
//               //                       ),
//               //                     ),
//               //                   ),
//               //                 );
//               //               });
//               //         }),
//               //         child: Text("Add Skills")),
//               //   ),
//               // ),
//               // SizedBox(
//               //   height: getProportionateScreenHeight(15)0,
//               // ),
//               // Center(
//               //   child: Container(
//               //     height: getProportionateScreenHeight(50),
//               //     width: getProportionateScreenWidth(300),
//               //     //   width: getProportionateScreenWidth(15)0,
//               //     child: ElevatedButton(
//               //       style: ElevatedButton.styleFrom(
//               //         primary: Colors.red,
//               //         // side: BorderSide(
//               //         //   width: getProportionateScreenWidth(1).0,
//               //         //   color: Colors.blueAccent,
//               //         // ),
//               //         shape: new RoundedRectangleBorder(
//               //           borderRadius: new BorderRadius.circular(20),
//               //         ),
//               //       ),
//               //       onPressed: () {
//               //         Get.off(PatelBottomBar());
//               //       },
//               //       child: Text(
//               //         'Submit',
//               //         style: TextStyle(color: Colors.white, fontSize: 20),
//               //       ),
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
