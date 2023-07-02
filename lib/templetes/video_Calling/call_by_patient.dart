import 'package:doctorandpatient/templetes/patient_screen/rating.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';
import '../../models/doctor_model.dart';
import 'contants.dart';

class CallBypatient extends StatelessWidget {
  const CallBypatient({
    super.key,
    required this.doctorModel,
    required this.conferenceID,
    required this.username,
    required this.userid,
  });
  final DoctorModel doctorModel;
  final String conferenceID;
  final String username;
  final String userid;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (context) =>
              Rating(doctorID: doctorModel.userID, rating: doctorModel.rating),
        );
      },
      child: SafeArea(
        child: ZegoUIKitPrebuiltVideoConference(
          appID: MyConst
              .appId, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
          appSign: MyConst
              .appSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
          userID: userid,
          userName: username,
          conferenceID: conferenceID,
          config: ZegoUIKitPrebuiltVideoConferenceConfig(),
        ),
      ),
    );
  }
}
