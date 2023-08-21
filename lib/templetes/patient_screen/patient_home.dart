import 'package:doctorandpatient/login.dart';
import 'package:doctorandpatient/templetes/patient_screen/appointment_history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/size_configuration.dart';
import '../../core/utils.dart';
import 'health_suggestion.dart';

class PatientHome extends StatelessWidget {
  const PatientHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Get.off(LoginPage());
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              icon: Icon(Icons.logout)),
        ],
        backgroundColor: Colors.red,
        title: Text(
          'Patient Panel',
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.8), BlendMode.dstATop),
                image: AssetImage("Assets/TELEHEALTH-1.jpeg"))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //  crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                doctor_homeCard(
                  text: 'Take Appointment',
                  image: "Assets/AdmissHis_card.png",
                ),
                SizedBox(
                  width: getProportionateScreenWidth(10),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(Suggestions());
                  },
                  child: doctor_homeCard(
                    text: 'Suggestion',
                    image: "Assets/Rectangle 22432 (1).png",
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(8),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                doctor_homeCard(
                  text: 'Doctor Rating',
                  image: "Assets/Rectangle 22431.png",
                ),
                SizedBox(
                  width: getProportionateScreenWidth(10),
                ),
                GestureDetector(
                  onTap: (() {
                    Get.to(AppointmentHistory());
                  }),
                  child: doctor_homeCard(
                    text: 'Appointment History',
                    image: "Assets/Rectangle 22430.png",
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(8),
            ),
          ],
        ),
      ),
    );
  }
}

class doctor_homeCard extends StatelessWidget {
  const doctor_homeCard({
    required this.image,
    required this.text,
    Key? key,
  }) : super(key: key);
  final String text;
  final image;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: getProportionateScreenHeight(140),
        width: getProportionateScreenWidth(180),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.red.shade200,
          boxShadow: [
            //   BoxShadow(color: Colors.black, spreadRadius: 2),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                scale: 4,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          ),
        ));
  }
}

// class HomeScreenCard extends StatelessWidget {
//   const HomeScreenCard({
//     Key? key,
//     required this.image,
//     required this.text,
//     required this.onTap,
//   }) : super(key: key);

//   final String image;
//   final String text;
//   final Function() onTap;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(width: getProportionateScreenWidth(1), color: Colors.grey.shade400),
//           borderRadius: const BorderRadius.all(
//             Radius.circular(14),
//           ),
//         ),
//         height: getProportionateScreenHeight(15),
//         width: getProportionateScreenWidth(1)7,
//         child: Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                   color: Colors.grey.shade400,
//                   borderRadius: const BorderRadius.only(
//                     bottomLeft: Radius.circular(20),
//                     bottomRight: Radius.circular(20),
//                   )),
//               height: getProportionateScreenHeight(7),
//               width: getProportionateScreenWidth(7),
//               child: Image.asset(
//                 image,
//                 scale: 4,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: 2.h),
//               child: Text(
//                 text,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
