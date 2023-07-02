import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorandpatient/login.dart';
import 'package:doctorandpatient/controller/create_appoint.dart';
import 'package:doctorandpatient/controller/doctor_schedule_controlller.dart';
import 'package:doctorandpatient/controller/doctors_controller.dart';
import 'package:doctorandpatient/controller/patient_controller.dart';
import 'package:doctorandpatient/controller/presiption_controller.dart';
import 'package:doctorandpatient/templetes/doctors_screen/doctor_dashboard.dart';
import 'package:doctorandpatient/templetes/doctors_screen/personal_info_Doc.dart';
import 'package:doctorandpatient/templetes/doctors_screen/rejected.dart';
import 'package:doctorandpatient/templetes/doctors_screen/verification.dart';
import 'package:doctorandpatient/templetes/patient_screen/patient_dashboard.dart';
import 'package:doctorandpatient/templetes/patient_screen/patient_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/invite_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    Get.put(DoctorController());
    Get.put(PatientController());
    Get.put(CreateAppointmentController());
    Get.put(DoctorSchedulesController());
    Get.put(PresiptionController());
    Get.put(InviteController());
    if (user != null) {
      User? user = FirebaseAuth.instance.currentUser;

      FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((DocumentSnapshot? snapshot) {
        if (snapshot != null && snapshot.exists) {
          final data = snapshot.data() as Map<String, dynamic>;
          if (data["rool"] == "Patient") {
            if (data["isVerified"] == "needData") {
              Timer(
                  const Duration(seconds: 3),
                  () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => (const PatientInfo()))));
            } else {
              Timer(
                  const Duration(seconds: 3),
                  () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          (PatientDashboard()))));
            }
          } else if (data["rool"] == "Doctor") {
            if (data["isVerified"] == "verified") {
              Timer(
                  const Duration(seconds: 3),
                  () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => (DoctorDashboard()))));
            } else if (data["isVerified"] == "inProcess") {
              Timer(
                  const Duration(seconds: 3),
                  () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          (const DoctorVerification()))));
            } else if (data["isVerified"] == "rejected") {
              Timer(
                  const Duration(seconds: 3),
                  () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => (const Rejected()))));
            } else if (data["isVerified"] == "needData") {
              Timer(
                  const Duration(seconds: 3),
                  () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => (const PersonalInfo()))));
            }
          }
        }
      });
    } else {
      Timer(
         const Duration(seconds: 3),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => (LoginPage()))));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Image.asset('Assets/vc.gif')],
      ),
    );
  }
}
