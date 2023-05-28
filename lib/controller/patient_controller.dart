import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/patient_model.dart';

class PatientController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchCustomerData();
  }

  List<PatientModel> _list = [];
  List<PatientModel> get getList => _list;
  fetchCustomerData() async {
    await FirebaseFirestore.instance
        .collection("patients")
        .get()
        .then((QuerySnapshot snapshot) {
      _list = [];
      for (var documents in snapshot.docs) {
        Map<String, dynamic> dataMap = documents.data() as Map<String, dynamic>;
        _list.insert(
            0, PatientModel.fromMap(map: dataMap, userID: documents.id.trim()));
      }
    });
    update();
  }

  PatientModel getPatientById(String userID) {
    return _list
        .firstWhere((element) => element.userID.trim() == userID.trim());
  }

  PatientModel getPatientByName(String firstName) {
    return _list
        .where((element) => element.name.trim() == firstName.trim())
        .first;
  }

  deletePatientData({required String userID}) async {
    await FirebaseFirestore.instance
        .collection("patients")
        .doc(userID)
        .delete();
    _list.removeWhere(
      (element) => element.userID == userID,
    );
    update();
  }
}
