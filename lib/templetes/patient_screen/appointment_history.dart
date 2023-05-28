import 'package:doctorandpatient/controller/patient_controller.dart';
import 'package:doctorandpatient/core/colors.dart';
import 'package:doctorandpatient/templetes/patient_screen/rating.dart';
import 'package:doctorandpatient/templetes/patient_screen/take_appointment.dart';
import 'package:doctorandpatient/templetes/patient_screen/viewpresiption.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/create_appoint.dart';
import '../../controller/doctor_schedule_controlller.dart';
import '../../controller/doctors_controller.dart';
import '../../core/size_configuration.dart';
import '../video_Calling/call.dart';

class AppointmentHistory extends StatefulWidget {
  const AppointmentHistory({super.key});

  @override
  State<AppointmentHistory> createState() => _AppointmentHistoryState();
}

final caController = Get.find<CreateAppointmentController>();
final dsController = Get.find<DoctorSchedulesController>();
final patientController = Get.find<PatientController>();
final doctorController = Get.find<DoctorController>();

class _AppointmentHistoryState extends State<AppointmentHistory> {
  @override
  Widget build(BuildContext context) {
    // video calling
    final doctor = doctorController.getDoctorById(FirebaseAuth.instance.currentUser!.uid);

    final dataList = caController.getList.where((element) =>
        (element.status == "Accepted" || element.status == "book") &&
        element.patientID == FirebaseAuth.instance.currentUser!.uid);
    return Scaffold(
        appBar: AppBar(
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back),
            //   onPressed: () => Get.off(DoctorDashboard()),
            // ),
            backgroundColor: Colors.red,
            title: Text('Appointment History')),
        body: Column(children: [
          SizedBox(
            height: getProportionateScreenHeight(719),
            width: getProportionateScreenWidth(400),
            child:
                GetBuilder<CreateAppointmentController>(builder: (controller) {
              return ListView.separated(
                  itemCount: dataList.length,
                  separatorBuilder: (context, index) => SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                  itemBuilder: (context, index) {
                    final data = dsController
                        .getById(dataList.elementAt(index).sheduleID);

                    return dataList.elementAt(index).status == "book"
                        ? AppointtmentViewCard(
                            date: data.date,
                            endTime: data.endTime,
                            doctorName: docController
                                    .getDoctorById(
                                        dataList.elementAt(index).doctorID)
                                    .firstName +
                                " " +
                                docController
                                    .getDoctorById(
                                        dataList.elementAt(index).doctorID)
                                    .lastName,
                            fees: data.fees,
                            startTime: data.startTime,
                          )
                        : AppointtmentAcceptedViewCard(
                            onCall: () {
                              Get.to(MYcall(
                                conferenceID: "1",
                                userid: "33",
                                username: "mustafa",
                              ));
                              // showDialog(
                              //   context: context,
                              //   builder: (context) => Rating(
                              //       doctorID:
                              //           dataList.elementAt(index).doctorID,
                              //       rating: docController
                              //           .getDoctorById(
                              //               dataList.elementAt(index).doctorID)
                              //           .rating),
                              // );
                            },
                            doctorID: data.doctorID,
                            patienID: dataList.elementAt(index).patientID,
                            fees: data.fees,
                            date: data.date,
                            endTime: data.endTime,
                            doctorName: docController
                                    .getDoctorById(
                                        dataList.elementAt(index).doctorID)
                                    .firstName +
                                " " +
                                docController
                                    .getDoctorById(
                                        dataList.elementAt(index).doctorID)
                                    .lastName,
                            startTime: data.startTime,
                          );
                  });
            }),
          )
        ]));
  }
}

class AppointtmentViewCard extends StatelessWidget {
  const AppointtmentViewCard({
    required this.doctorName,
    required this.startTime,
    required this.endTime,
    required this.date,
    Key? key,
    required this.fees,
  }) : super(key: key);

  final String fees;
  final String doctorName;
  final String startTime;
  final String endTime;
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: getProportionateScreenHeight(210),
        width: getProportionateScreenWidth(350),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(color: AppColors.btnlogingreyGreen, spreadRadius: 2),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(5),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      "Name:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(5),
                    ),
                    Text(
                      doctorName,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
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
                      Text("Start time:"),
                      SizedBox(
                        width: getProportionateScreenWidth(5),
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
                        width: getProportionateScreenWidth(5),
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
                      Text("Day:"),
                      SizedBox(
                        width: getProportionateScreenWidth(5),
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
                        width: getProportionateScreenWidth(10),
                      ),
                      Text(fees),
                    ],
                  )),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Container(
              color: Colors.green,
              height: getProportionateScreenHeight(40),
              width: getProportionateScreenWidth(350),
              child: Center(
                  child: Text(
                "Request Pending",
                style: TextStyle(fontSize: 24, color: Colors.white),
              )),
            ),
          ],
        ),
      ),
    );
  }
}

class AppointtmentAcceptedViewCard extends StatelessWidget {
  const AppointtmentAcceptedViewCard({
    required this.doctorName,
    required this.startTime,
    required this.endTime,
    required this.date,
    Key? key,
    required this.fees,
    required this.patienID,
    required this.doctorID,
    this.onCall,
  }) : super(key: key);

  final void Function()? onCall;
  final String doctorName;
  final String startTime;
  final String endTime;
  final DateTime date;
  final String fees;
  final String patienID;
  final String doctorID;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: getProportionateScreenHeight(210),
        width: getProportionateScreenWidth(350),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(10),
                    ),
                    Text(
                      doctorName,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
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
                      Text("Start time:"),
                      SizedBox(
                        width: getProportionateScreenWidth(10),
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
                        width: getProportionateScreenWidth(10),
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
                      Text("Day:"),
                      SizedBox(
                        width: getProportionateScreenWidth(10),
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
                        width: getProportionateScreenWidth(10),
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
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Container(
                  height: getProportionateScreenHeight(40),
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
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  height: getProportionateScreenHeight(40),
                  width: getProportionateScreenWidth(120),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(ViewPerciption(
                        doctorID: doctorID,
                        patientID: patienID,
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      // side: BorderSide(
                      //   width: getProportionateScreenWidth(1).0,
                      //   color: Colors.blueAccent,
                      // ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Presiption',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  height: getProportionateScreenHeight(40),
                  width: getProportionateScreenWidth(100),
                  child: ElevatedButton(
                    onPressed: onCall,
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
                      'call',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
