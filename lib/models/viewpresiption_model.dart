// class ViewPresiptionModel {
//   final String text;
//   final String patientID;
//   final String doctorID;
//   final String userID;

//   ViewPresiptionModel({
//     required this.userID,
//     required this.patientID,
//     required this.text,
//     required this.doctorID,
//   });

//   factory ViewPresiptionModel.fromMap(
//       {required Map<String, dynamic> map, required String userID}) {
//     return ViewPresiptionModel(
//       userID: userID,
//       doctorID: map['doctorID'],
//       patientID: map['patientID'],
//       text: map["text"],
//     );
//   }
//   Map<String, dynamic> toMap() {
//     return {
//       "patientID": patientID,
//       "text": text,
//       "doctorID": doctorID,
//     };
//   }
// }
