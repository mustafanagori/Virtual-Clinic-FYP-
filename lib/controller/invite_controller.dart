import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/invite_model.dart';

class InviteController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchCustomerData();
  }

  List<InviteModel> _list = [];
  List<InviteModel> get getList => _list;
  fetchCustomerData() async {
    await FirebaseFirestore.instance
        .collection("invites")
        .get()
        .then((QuerySnapshot snapshot) {
      _list = [];
      for (var documents in snapshot.docs) {
        Map<String, dynamic> dataMap = documents.data() as Map<String, dynamic>;
        _list.insert(
            0, InviteModel.fromMap(map: dataMap, userID: documents.id.trim()));
      }
    });
    print(_list.toList());
    update();
  }
}
