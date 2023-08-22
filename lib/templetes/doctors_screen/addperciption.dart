import 'package:doctorandpatient/controller/presiption_controller.dart';
import 'package:doctorandpatient/core/size_configuration.dart';
import 'package:doctorandpatient/core/mytextfield.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

// new one
// ignore: must_be_immutable
class Perciption extends StatefulWidget {
  const Perciption(
      {super.key, required this.patientID, required this.doctorID});
  final String patientID;
  final String doctorID;

  @override
  State<Perciption> createState() => _PerciptionState();
}

class _PerciptionState extends State<Perciption> {
  TextEditingController text = TextEditingController();
  final presiptionController = Get.put(PresiptionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "Add Presiption",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          height: getProportionateScreenHeight(680),
          width: getProportionateScreenWidth(390),
          color: Colors.white,
          child: GetBuilder<PresiptionController>(
              init: PresiptionController(),
              builder: (controller) {
                final presiptionList = presiptionController.getList.where(
                    (element) =>
                        element.doctorID == widget.doctorID &&
                        element.patientID == widget.patientID);
                return ListView.builder(
                    itemBuilder: (context, index) => msgbox(
                          message: presiptionList.elementAt(index).text,
                        ),
                    itemCount: presiptionList.length);
              })),
      bottomSheet: Container(
        height: getProportionateScreenHeight(60),
        width: getProportionateScreenWidth(375),
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MyTextField(
              controller: text,
              height: getProportionateScreenHeight(30),
              width: getProportionateScreenWidth(350),
              leading: IconButton(
                  onPressed: () async {
                    await presiptionController.upload(
                        text: text.text,
                        patientID: widget.patientID,
                        doctorID: widget.doctorID);

                    setState(() {
                      presiptionController.fetchData();
                      text.text = "";
                    });
                  },
                  icon: const Icon(Icons.send)),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class msgbox extends StatelessWidget {
  const msgbox({
    super.key,
    required this.message,
  });
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Container(
          // height: getProportionateScreenHeight(150),
          // width: getProportionateScreenWidth(350),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Color.fromARGB(255, 228, 208, 208),
          ),

          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              message,
              style: const TextStyle(
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
