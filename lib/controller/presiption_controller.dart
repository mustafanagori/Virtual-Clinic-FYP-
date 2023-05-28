import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/presiption_model.dart';

class PresiptionController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  List<PresiptionModel> _list = [];
  List<PresiptionModel> get getList => _list;
  fetchData() async {
    await FirebaseFirestore.instance
        .collection("presiption")
        .get()
        .then((QuerySnapshot snapshot) {
      _list = [];
      for (var documents in snapshot.docs) {
        Map<String, dynamic> dataMap = documents.data() as Map<String, dynamic>;
        _list.insert(0,
            PresiptionModel.fromMap(map: dataMap, userID: documents.id.trim()));
      }
    });
    update();
  }

  PresiptionModel getPatientById(String userID) {
    return _list
        .firstWhere((element) => element.userID.trim() == userID.trim());
  }

  deletePatientData({required String userID}) async {
    await FirebaseFirestore.instance
        .collection("presiption")
        .doc(userID)
        .delete();
    _list.removeWhere(
      (element) => element.userID == userID,
    );
    update();
  }

  upload(
      {required String text,
      required String patientID,
      required String doctorID}) async {
    await FirebaseFirestore.instance
        .collection("presiption")
        .add({"text": text, "doctorID": doctorID, "patientID": patientID});

    fetchData();
  }
}
