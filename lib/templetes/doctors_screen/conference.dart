import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorandpatient/controller/invite_controller.dart';
import 'package:doctorandpatient/templetes/video_Calling/call_by_doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/doctors_controller.dart';
import '../../models/doctor_model.dart';

class Conference extends StatefulWidget {
  const Conference({Key? key}) : super(key: key);

  @override
  State<Conference> createState() => _ConferenceState();
}

class _ConferenceState extends State<Conference> {
  bool loading = false;
  DoctorController doctorController = Get.put(DoctorController());
  InviteController invController = Get.put(InviteController());

  @override
  Widget build(BuildContext context) {
    Iterable<DoctorModel> invitesList = doctorController.getList.where(
      (element) => invController.getList.any(
        (invElement) =>
            element.userID == invElement.drInvitedBy &&
            element.userID == invElement.drInvitedTo,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Conference Room"),
      ),
      body: loading
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: invitesList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    "${invitesList.elementAt(index).firstName} ${invitesList.elementAt(index).lastName}", // Replace with the actual doctor's name
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    "has invited you ", // Replace with the doctor's specialty
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      Get.to(CallByDoctor(
                          conferenceID: "1",
                          username:
                              "${doctorController.getDoctorById(FirebaseAuth.instance.currentUser!.uid).firstName} ${doctorController.getDoctorById(FirebaseAuth.instance.currentUser!.uid).lastName}",
                          userid: FirebaseAuth.instance.currentUser!.uid));
                      // Handle button press
                    },
                    child: const Text('Call'), // Text content of the button
                  ),
                );
              },
            ),
    );
  }
}
