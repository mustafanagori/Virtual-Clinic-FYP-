import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorandpatient/controller/presiption_controller.dart';
import 'package:doctorandpatient/core/size_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ViewPerciption extends StatelessWidget {
  ViewPerciption({super.key, required this.patientID, required this.doctorID});
  final String patientID;
  final String doctorID;
  TextEditingController text = TextEditingController();
  final presiptionController = Get.find<PresiptionController>();

  @override
  Widget build(BuildContext context) {
    final viewPresiptionList = presiptionController.getList.where((element) =>
        element.doctorID == doctorID && element.patientID == patientID);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "View Presiption",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: getProportionateScreenHeight(730),
        width: getProportionateScreenWidth(390),
        color: Colors.white,
        child: ListView.builder(
            itemBuilder: (context, index) => msgbox2(
                  message2: viewPresiptionList.elementAt(index).text,
                ),
            itemCount: viewPresiptionList.length),
      ),
    );
  }
}

class msgbox2 extends StatelessWidget {
  const msgbox2({
    super.key,
    required this.message2,
  });
  final String message2;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Container(
          // height: getProportionateScreenHeight(150),
          // width: getProportionateScreenWidth(350),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: const Color.fromARGB(255, 228, 208, 208),
          ),

          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              message2,
              style: TextStyle(
                fontSize: 25,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
