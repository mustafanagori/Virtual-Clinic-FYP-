import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';
import '../../controller/doctors_controller.dart';
import 'contants.dart';

class CallByDoctor extends StatelessWidget {
  DoctorController doctorController = Get.put(DoctorController());

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
                      return ListView.builder(
                        itemCount: drlist.length,
                        itemBuilder: (context, index) => ListTile(
                          trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {},
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
