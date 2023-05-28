// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import '../models/viewpresiption_model.dart';

// class ViewPresiptionController extends GetxController {
//   @override
//   void onInit() {
//     super.onInit();
//     fetchCustomerData();
//   }

//   List<ViewPresiptionModel> _list = [];
//   List<ViewPresiptionModel> get getList => _list;
//   fetchCustomerData() async {
//     await FirebaseFirestore.instance
//         .collection("presiption")
//         .get()
//         .then((QuerySnapshot snapshot) {
//       _list = [];
//       for (var documents in snapshot.docs) {
//         Map<String, dynamic> dataMap = documents.data() as Map<String, dynamic>;
//         _list.insert(
//             0,
//             ViewPresiptionModel.fromMap(
//                 map: dataMap, userID: documents.id.trim()));
//       }
//     });
//     update();
//   }

//   ViewPresiptionModel getPatientById(String userID) {
//     return _list
//         .firstWhere((element) => element.userID.trim() == userID.trim());
//   }

//   deletePatientData({required String userID}) async {
//     await FirebaseFirestore.instance
//         .collection("presiption")
//         .doc(userID)
//         .delete();
//     _list.removeWhere(
//       (element) => element.userID == userID,
//     );
//     update();
//   }
// }
