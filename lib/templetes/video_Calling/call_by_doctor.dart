import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';
import 'contants.dart';

class callByDoctor extends StatelessWidget {
  const callByDoctor({
    super.key,
    required this.conferenceID,
    required this.username,
    required this.userid,
  });
  final String conferenceID;
  final String username;
  final String userid;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
    );
  }
}
