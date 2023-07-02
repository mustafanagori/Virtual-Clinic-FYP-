import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/doctor_model.dart';

class DoctorController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  List<DoctorModel> _list = [];
  List<DoctorModel> get getList => _list;
  fetchData() async {
    await FirebaseFirestore.instance
        .collection("doctors")
        .get()
        .then((QuerySnapshot snapshot) {
      _list = [];
      for (var documents in snapshot.docs) {
        Map<String, dynamic> dataMap = documents.data() as Map<String, dynamic>;
        _list.insert(
            0, DoctorModel.fromMap(map: dataMap, userID: documents.id.trim()));
      }
    });
    update();
  }

  updateRating({required String doctorID, required List rating}) async {
    await FirebaseFirestore.instance
        .collection("doctors")
        .doc(doctorID)
        .update({"rating": rating});
  }

  DoctorModel getDoctorById(String userID) {
    fetchData();

    print(userID);
    return _list
        .firstWhere((element) => element.userID.trim() == userID.trim());
  }

  DoctorModel getCustomerByName(String firstName) {
    return _list
        .where((element) => element.firstName.trim() == firstName.trim())
        .first;
  }

  deleteCustomerData({required String userID}) async {
    await FirebaseFirestore.instance.collection("doctors").doc(userID).delete();
    _list.removeWhere(
      (element) => element.userID == userID,
    );
    update();
  }
}
