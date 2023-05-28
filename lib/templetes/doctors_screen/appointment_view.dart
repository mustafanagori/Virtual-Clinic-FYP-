import 'package:doctorandpatient/controller/patient_controller.dart';
import 'package:doctorandpatient/core/colors.dart';
import 'package:doctorandpatient/models/doctor_scheduleModel.dart';
import 'package:doctorandpatient/templetes/patient_screen/rating.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/create_appoint.dart';
import '../../controller/doctor_schedule_controlller.dart';
import '../../core/utils.dart';
import '../../core/size_configuration.dart';
import 'addperciption.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

final caController = Get.put(CreateAppointmentController());
final dsController = Get.put(DoctorSchedulesController());
final patientController = Get.put(PatientController());
// final caController = Get.find<CreateAppointmentController>();

// final dsController = Get.find<DoctorSchedulesController>();
// final patientController = Get.find<PatientController>();

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    final dataList = caController.getList.where((element) =>
        (element.status == "book" || element.status == "Accepted") &&
        element.doctorID == FirebaseAuth.instance.currentUser!.uid);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('View Appointment'),
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Get.back();
          //   },
          // ),
        ),
        body: Column(children: [
          SizedBox(
            height: getProportionateScreenHeight(670),
            width: getProportionateScreenWidth(400),
            child:
                GetBuilder<CreateAppointmentController>(builder: (controller) {
              return ListView.separated(
                  itemCount: dataList.length,
                  separatorBuilder: (context, index) => SizedBox(
                        height: getProportionateScreenHeight(5),
                      ),
                  itemBuilder: (context, index) {
                    final DoctorScheduleModel data = dsController
                        .getById(dataList.elementAt(index).sheduleID);

                    return
                        //  dataList.elementAt(index).status == "book"
                        //     ?
                        AppointtmentViewCard(
                      fees: data.fees,
                      onPressedReject: () async {
                        await caController.deleteData(
                            userID: dataList.elementAt(index).userID);
                        Utils().toastMessage("Rejected");
                      },
                      onPressedAccept: () async {
                        await caController.updateStatus(
                            dataList.elementAt(index).userID, "Accepted");

                        Utils().toastMessage("Accepted");
                      },
                      date: data.date,
                      endTime: data.endTime,
                      patientName: patientController
                          .getPatientById(dataList.elementAt(index).patientID)
                          .name,
                      startTime: data.startTime,
                    );
                    // : AppointtmentAcceptedViewCard(
                    //     fees: data.fees,
                    //     date: data.date,
                    //     endTime: data.endTime,
                    //     patientName: patientController
                    //         .getPatientById(
                    //             dataList.elementAt(index).patientID)
                    //         .name,
                    //     startTime: data.startTime,
                    //     doctorID: data.doctorID,
                    //     patientID: patientController
                    //         .getPatientById(
                    //             dataList.elementAt(index).patientID)
                    //         .userID,
                    //   );
                  });
            }),
          )
        ]));
  }
}

class AppointtmentViewCard extends StatelessWidget {
  const AppointtmentViewCard({
    required this.patientName,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.onPressedAccept,
    required this.onPressedReject,
    Key? key,
    required this.fees,
  }) : super(key: key);
  final void Function()? onPressedAccept;

  final void Function()? onPressedReject;
  final String patientName;
  final String startTime;
  final String endTime;
  final DateTime date;
  final String fees;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: getProportionateScreenHeight(190),
          width: getProportionateScreenWidth(500),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: AppColors.btnlogingreyGreen, spreadRadius: 2),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        "Name:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(20),
                      ),
                      Text(
                        patientName,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text("Start time:"),
                        SizedBox(
                          width: getProportionateScreenWidth(20),
                        ),
                        Text(startTime),
                      ],
                    )),
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text("End Time:"),
                        SizedBox(
                          width: getProportionateScreenWidth(20),
                        ),
                        Text(endTime),
                      ],
                    )),
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text("Date:"),
                        SizedBox(
                          width: getProportionateScreenWidth(20),
                        ),
                        Text(date.toString().split(" ")[0]),
                      ],
                    )),
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text("Fees:"),
                        SizedBox(
                          width: getProportionateScreenWidth(20),
                        ),
                        Text(fees),
                      ],
                    )),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(40),
                    width: getProportionateScreenWidth(120),
                    //   width: getProportionateScreenWidth(15)0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: onPressedAccept,
                      child: Text(
                        'Accept',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AppointtmentAcceptedViewCard extends StatelessWidget {
  const AppointtmentAcceptedViewCard({
    required this.patientName,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.patientID,
    required this.doctorID,
    Key? key,
    required this.fees,
  }) : super(key: key);
  final String patientName;
  final String startTime;
  final String endTime;
  final DateTime date;
  final String fees;
  final String patientID;
  final String doctorID;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: getProportionateScreenHeight(210),
          width: getProportionateScreenWidth(500),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: AppColors.btnlogingreyGreen, spreadRadius: 2),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        "Name:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(20),
                      ),
                      Text(
                        patientName,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text("Start time:"),
                        SizedBox(
                          width: getProportionateScreenWidth(20),
                        ),
                        Text(startTime),
                      ],
                    )),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text("End Time:"),
                        SizedBox(
                          width: getProportionateScreenWidth(20),
                        ),
                        Text(endTime),
                      ],
                    )),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text("Date:"),
                        SizedBox(
                          width: getProportionateScreenWidth(20),
                        ),
                        Text(date.toString().split(" ")[0]),
                      ],
                    )),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text("Fees:"),
                        SizedBox(
                          width: getProportionateScreenWidth(20),
                        ),
                        Text(fees),
                      ],
                    )),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: getProportionateScreenHeight(50),
                    width: getProportionateScreenWidth(100),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        // side: BorderSide(
                        //   width: getProportionateScreenWidth(1).0,
                        //   color: Colors.blueAccent,
                        // ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Booked',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(50),
                    width: getProportionateScreenWidth(100),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(Perciption(
                          patientID: patientID,
                          doctorID: doctorID,
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Presiption',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                  Container(
                    height: getProportionateScreenHeight(50),
                    width: getProportionateScreenWidth(100),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        // side: BorderSide(
                        //   width: getProportionateScreenWidth(1).0,
                        //   color: Colors.blueAccent,
                        // ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Call',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
