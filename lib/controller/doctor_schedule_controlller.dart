import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorandpatient/models/create_appointment_model.dart';
import 'package:get/get.dart';

import '../models/doctor_scheduleModel.dart';

class DoctorSchedulesController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    fetchData();
  }

  RxBool isLoading = false.obs;
  RxList<DoctorScheduleModel> _list = <DoctorScheduleModel>[].obs;
  List<DoctorScheduleModel> get getList => _list;
  Future fetchData() async {
    isLoading(true);
    await FirebaseFirestore.instance
        .collection("doctorSchedule")
        .get()
        .then((QuerySnapshot snapshot) {
      _list = <DoctorScheduleModel>[].obs;
      for (var documents in snapshot.docs) {
        Map<String, dynamic> dataMap = documents.data() as Map<String, dynamic>;
        _list.insert(
            0,
            DoctorScheduleModel.fromMap(
                map: dataMap, userID: documents.id.trim()));
      }
    });

    update();
    isLoading(false);
  }

  List<DoctorScheduleModel> getData(List<CreateAppointmentModel> caList) {
    List<DoctorScheduleModel> temp = List.from(_list);

    for (CreateAppointmentModel ca in caList) {
      temp.removeWhere((ds) => ca.sheduleID == ds.userID);
    }

    return temp;
  }

  DoctorScheduleModel getById(String userID) {
    return _list
        .firstWhere((element) => element.userID.trim() == userID.trim());
  }

  uploadData(
      {required String startTime,
      required String endTime,
      required String day,
      required String docID,
      required String fees}) async {
    final doc =
        await FirebaseFirestore.instance.collection("doctorSchedule").add({
      "startTime": startTime,
      "endTime": endTime,
      "doctorID": docID,
      "day": day,
      "fees": fees,
    });
    _list.insert(
        0,
        DoctorScheduleModel(
          userID: doc.id,
          startTime: startTime,
          endTime: endTime,
          doctorID: docID,
          day: day,
          fees: fees,
        ));
    update();

    fetchData();
  }

  deleteData({required String userID}) async {
    isLoading(true);
    await FirebaseFirestore.instance
        .collection("doctorSchedule")
        .doc(userID)
        .delete();
    _list.removeWhere((element) => element.userID == userID);
    isLoading(false);
  }
}



















// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:doctorandpatient/models/create_appointment_model.dart';
// import 'package:get/get.dart';
// import '../models/doctor_scheduleModel.dart';

// class DoctorSchedulesController extends GetxController {
//   @override
//   void onInit() {
//     super.onInit();
//     fetchData();
//   }

//   List<DoctorScheduleModel> _list = [];
//   List<DoctorScheduleModel> get getList => _list;
//   fetchData() async {
//     await FirebaseFirestore.instance
//         .collection("doctorSchedule")
//         .get()
//         .then((QuerySnapshot snapshot) {
//       _list = [];
//       for (var documents in snapshot.docs) {
//         Map<String, dynamic> dataMap = documents.data() as Map<String, dynamic>;
//         _list.insert(
//             0,
//             DoctorScheduleModel.fromMap(
//                 map: dataMap, userID: documents.id.trim()));
//       }
//     });
//     update();
//   }

//   // List<DoctorScheduleModel> getData(List<CreateAppointmentModel> caList) {
//   //   List<DoctorScheduleModel> temp = _list;

//   //   for (CreateAppointmentModel ca in caList) {
//   //     for (DoctorScheduleModel ds in temp) {
//   //       if (ca.sheduleID == ds.userID) {
//   //         temp.remove(ds);
//   //       }
//   //     }
//   //   }
//   //   return temp;
//   // }
//   List<DoctorScheduleModel> getData(List<CreateAppointmentModel> caList) {
//     fetchData();
//     List<DoctorScheduleModel> temp = List.from(_list);

//     for (CreateAppointmentModel ca in caList) {
//       temp.removeWhere((ds) => ca.sheduleID == ds.userID);
//     }

//     return temp;
//   }

//   DoctorScheduleModel getById(String userID) {
//     fetchData();
//     return _list
//         .firstWhere((element) => element.userID.trim() == userID.trim());
//   }

//   uploadData(
//       {required String startTime,
//       required String endTime,
//       required String day,
//       required String docID,
//       required String fees}) async {
//     fetchData();
//     final doc =
//         await FirebaseFirestore.instance.collection("doctorSchedule").add({
//       "startTime": startTime,
//       "endTime": endTime,
//       "doctorID": docID,
//       "day": day,
//       "fees": fees,
//     });
//     _list.insert(
//         0,
//         DoctorScheduleModel(
//           userID: doc.id,
//           startTime: startTime,
//           endTime: endTime,
//           doctorID: docID,
//           day: day,
//           fees: fees,
//         ));
//     update();

//     fetchData();
//   }

//   deleteData({required String userID}) async {
//     fetchData();
//     await FirebaseFirestore.instance
//         .collection("doctorSchedule")
//         .doc(userID)
//         .delete();
//     _list.removeWhere(
//       (element) => element.userID == userID,
//     );
//     update();
//   }
// }
