// // ignore_for_file: dead_code


// import 'package:flutter/material.dart';

// class MyLogin extends StatelessWidget {
//   const MyLogin({super.key});
//   static String name = "";
//   static String userId = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Login"),
//         ),
//         body: Container(
//           margin: const EdgeInsets.only(left: 30, right: 30),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextField(
//                 onChanged: (val) {
//                   name = val;
//                 },
//                 decoration: const InputDecoration(
//                     hintText: ("Enter Your Name "),
//                     border: OutlineInputBorder()),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               TextField(
//                 onChanged: (val) {
//                   userId = val;
//                 },
//                 decoration: const InputDecoration(
//                     hintText: ("Enter Your User ID "),
//                     border: OutlineInputBorder()),
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => MyHome(),
//                         ));
//                   },
//                   child: const Text("Submit"))
//             ],
//           ),
//         ));
//   }
// }
