// import 'package:doctorandpatient/templetes/doctors_screen/utliscall.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:get/get.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'dart:math' as math;

// import '../doctors_screen/personal_info_Doc.dart';

// final userId = math.Random().nextInt(10000).toString();

// class GroupCallScreen extends StatelessWidget {
//   final callingId = TextEditingController(text: "group_call_id");
//   GroupCallScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           Expanded(
//               child: TextFormField(
//             controller: callingId,
//             decoration: InputDecoration(labelText: "Join group call by id"),
//           )),
//           ElevatedButton(
//               onPressed: () {
//                 Get.off(callingPage(
//                   callingId: callingId.text.toString(),
//                 ));
//               },
//               child: Text("Join"))
//         ],
//       ),
//     );
//   }
// }

// class callingPage extends StatelessWidget {
//   const callingPage({super.key, required this.callingId});
//   final String callingId;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: ZegoUIKitPrebuiltCall(
//         appID: Utils.appId,
//         appSign: Utils.appSignin,
//         userID: userId,
//         userName: "username_$userId",
//         callID: callingId,
//         config: ZegoUIKitPrebuiltCallConfig.groupVideoCall(),
//       ),
//     );
//   }
// }
