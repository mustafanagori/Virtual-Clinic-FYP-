import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/create_appointment_model.dart';

class CreateAppointmentController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  List<CreateAppointmentModel> _list = [];
  List<CreateAppointmentModel> get getList => _list;
  fetchData() async {
    await FirebaseFirestore.instance
        .collection("createAppointment")
        .get()
        .then((QuerySnapshot snapshot) {
      _list = [];
      for (var documents in snapshot.docs) {
        Map<String, dynamic> dataMap = documents.data() as Map<String, dynamic>;
        _list.insert(
            0,
            CreateAppointmentModel.fromMap(
                map: dataMap, userID: documents.id.trim()));
      }
    });
    update();
    fetchData();
  }

  uploadData(
      {required String patientID,
      required String doctorID,
      required String sheduleID,
      required String status}) async {
    await FirebaseFirestore.instance.collection("createAppointment").add({
      "patientID": patientID,
      "sheduleID": sheduleID,
      "doctorID": doctorID,
      "status": status,
    });
    update();
    fetchData();
  }

  updateStatus(
    String id,
    String status,
  ) async {
    fetchData();
    await FirebaseFirestore.instance
        .collection("createAppointment")
        .doc(id)
        .update({"status": status});

    _list
        .firstWhere(
          (element) => element.userID == id,
        )
        .status = status;

    update();
    fetchData();
  }

  CreateAppointmentModel getPatientById(String userID) {
    fetchData();
    return _list
        .firstWhere((element) => element.userID.trim() == userID.trim());
  }

  deleteData({required String userID}) async {
    await FirebaseFirestore.instance
        .collection("createAppointment")
        .doc(userID)
        .delete();
    _list.removeWhere(
      (element) => element.userID == userID,
    );
    update();
    fetchData();
  }
}
