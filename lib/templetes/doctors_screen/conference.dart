import 'package:doctorandpatient/controller/invite_controller.dart';
import 'package:doctorandpatient/templetes/video_Calling/call_by_doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/doctors_controller.dart';
import '../../models/doctor_model.dart';
import '../video_Calling/call_by_conference.dart';

class Conference extends StatefulWidget {
  const Conference({Key? key}) : super(key: key);

  @override
  State<Conference> createState() => _ConferenceState();
}

class _ConferenceState extends State<Conference> {
  bool loading = false;
  DoctorController doctorController = Get.put(DoctorController());
  InviteController invController = Get.put(InviteController());
  // search(){

  //   for(var element in doctorController.getList){
  //     if(element.userID == invController.getList
  //             .contains(element.userID)
  //             ){

  //     }
  //   }

  // }
  @override
  Widget build(BuildContext context) {
    // Iterable<DoctorModel> invitesList = doctorController.getList.where(
    //   (element) => invController.getList.any(
    //     (invElement) =>
    //         element.userID == invElement.drInvitedBy &&
    //         element.userID == invElement.drInvitedTo,
    //   ),
    // );
    Iterable<DoctorModel> invitesList = doctorController.getList.where(
        (element) =>
            invController.getList.any((invelement) =>
                invelement.drInvitedTo ==
                FirebaseAuth.instance.currentUser!.uid) &&
            invController.getList
                .any((invelement) => invelement.drInvitedBy == element.userID));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Conference Room"),
      ),
      body: loading
          ? const CircularProgressIndicator()
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
                  subtitle: const Text(
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
                      Get.to(CallByConference(
                          conferenceID: "1",
                          username:
                              "${doctorController.getDoctorById(FirebaseAuth.instance.currentUser!.uid).firstName} ${doctorController.getDoctorById(FirebaseAuth.instance.currentUser!.uid).lastName}",
                          userid: FirebaseAuth.instance.currentUser!.uid));
                      // Handle button press
                    },
                    child: const Text('Join'), // Text content of the button
                  ),
                );
              },
            ),
    );
  }
}
