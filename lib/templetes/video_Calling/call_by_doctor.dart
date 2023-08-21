import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorandpatient/core/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';
import '../../controller/doctors_controller.dart';
import 'contants.dart';

class CallByDoctor extends StatelessWidget {
  final DoctorController doctorController = Get.put(DoctorController());

  CallByDoctor({
    Key? key,
    required this.conferenceID,
    required this.username,
    required this.userid,
  }) : super(key: key);

  final String conferenceID;
  final String username;
  final String userid;

  @override
  Widget build(BuildContext context) {
    var drlist = doctorController.getList;
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ZegoUIKitPrebuiltVideoConference(
              appID: MyConst.appId,
              appSign: MyConst.appSign,
              userID: userid,
              userName: username,
              conferenceID: conferenceID,
              config: ZegoUIKitPrebuiltVideoConferenceConfig(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return ListView.separated(
                        separatorBuilder: (context, index) => const Divider(
                          thickness: 2,
                        ),
                        itemCount: drlist.length,
                        itemBuilder: (context, index) => ListTile(
                          trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection("invites")
                                    .add({
                                  "invitedBy": FirebaseAuth
                                      .instance.currentUser!.uid
                                      .toString(),
                                  "invitedTo": drlist[index].userID,
                                }).then((value) => Utils().toastMessage(
                                        "Dr.${drlist[index].firstName} Invited"));
                              },
                              child: const Text("Invite ")),
                          title: Text(
                            "${drlist[index].firstName} ${drlist[index].lastName}",
                          ),
                          subtitle: Text(drlist[index].prno.toString()),
                        ),
                      );
                    },
                  );
                },
                child: const Text('Add Conference'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
