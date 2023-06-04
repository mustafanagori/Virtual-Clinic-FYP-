import 'package:doctorandpatient/controller/doctors_controller.dart';
import 'package:doctorandpatient/controller/patient_controller.dart';
import 'package:doctorandpatient/core/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/create_appoint.dart';
import '../../controller/doctor_schedule_controlller.dart';
import '../../core/size_configuration.dart';

import '../video_Calling/call_by_doctor.dart';
import 'addperciption.dart';

class PatientHistory extends StatefulWidget {
  const PatientHistory({super.key});

  @override
  State<PatientHistory> createState() => _PatientHistoryState();
}

final caController = Get.find<CreateAppointmentController>();
final dsController = Get.find<DoctorSchedulesController>();
final patientController = Get.find<PatientController>();

class _PatientHistoryState extends State<PatientHistory> {
  @override
  Widget build(BuildContext context) {
    // video calling

    final dataList = caController.getList.where((element) =>
        element.status == "Accepted" &&
        element.doctorID == FirebaseAuth.instance.currentUser!.uid);
    return Scaffold(
        appBar: AppBar(
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back),
            //   onPressed: () => Get.off(DoctorDashboard()),
            // ),
            backgroundColor: Colors.red,
            title: Text('Appointment History')),
        body: GetBuilder<CreateAppointmentController>(builder: (controller) {
          return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                final data =
                    dsController.getById(dataList.elementAt(index).sheduleID);

                return checkTime(
                            day: data.day,
                            startHour: int.parse(
                                data.startTime.split("(")[1].split(":")[0]),
                            endHour: int.parse(
                                data.endTime.split("(")[1].split(":")[0]),
                            startMinute: int.parse(
                                data.startTime.split(":")[1].split(")")[0]),
                            endMinute: int.parse(
                                data.endTime.split(":")[1].split(")")[0])) ==
                        true
                    ? DuringAppointtmentAcceptedViewCard(
                        patientID: dataList.elementAt(index).patientID,
                        doctorID: data.doctorID,
                        fees: data.fees,
                        day: data.day,
                        endTime: data.endTime,
                        patientName: patientController
                            .getPatientById(dataList.elementAt(index).patientID)
                            .name,
                        startTime: data.startTime,
                      )
                    : BeforeAppointmentViewCard(
                        patientID: dataList.elementAt(index).patientID,
                        doctorID: data.doctorID,
                        fees: data.fees,
                        day: data.day,
                        endTime: data.endTime,
                        patientName: patientController
                            .getPatientById(dataList.elementAt(index).patientID)
                            .name,
                        startTime: data.startTime,
                      );
              });
        }));
  }
}

class AppointtmentViewCard extends StatelessWidget {
  const AppointtmentViewCard({
    required this.patientName,
    required this.startTime,
    required this.endTime,
    required this.day,
    required this.fees,
    required this.onPressedAccept,
    required this.onPressedReject,
    Key? key,
  }) : super(key: key);
  final void Function()? onPressedAccept;
  final void Function()? onPressedReject;
  final String patientName;
  final String fees;
  final String startTime;
  final String endTime;
  final String day;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: getProportionateScreenHeight(120),
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
                height: getProportionateScreenHeight(20),
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
                          width: getProportionateScreenWidth(10),
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
                        Text("Day:"),
                        SizedBox(
                          width: getProportionateScreenWidth(20),
                        ),
                        Text(day.toString().split(" ")[0]),
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
                    height: getProportionateScreenHeight(15),
                    width: getProportionateScreenWidth(40),
                    //   width: getProportionateScreenWidth(15)0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        // side: BorderSide(
                        //   width: getProportionateScreenWidth(1).0,
                        //   color: Colors.blueAccent,
                        // ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: onPressedReject,
                      child: Text(
                        'Reject',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                    width: getProportionateScreenWidth(50),
                    //   width: getProportionateScreenWidth(15)0,
                    child: ElevatedButton(
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

class DuringAppointtmentAcceptedViewCard extends StatelessWidget {
  const DuringAppointtmentAcceptedViewCard({
    required this.patientName,
    required this.startTime,
    required this.endTime,
    required this.day,
    required this.patientID,
    required this.doctorID,
    Key? key,
    required this.fees,
  }) : super(key: key);
  final String patientName;
  final String startTime;
  final String patientID;
  final String doctorID;

  final String fees;
  final String endTime;
  final String day;
  @override
  Widget build(BuildContext context) {
    final doctorController = Get.find<DoctorController>();
    final doctor =
        doctorController.getDoctorById(FirebaseAuth.instance.currentUser!.uid);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: getProportionateScreenHeight(200),
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(10),
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
                        Text(day.toString().split(" ")[0]),
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
                        Get.to(Perciption(
                            patientID: patientID, doctorID: doctorID));
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
                        'Perception',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    height: getProportionateScreenHeight(40),
                    width: getProportionateScreenWidth(100),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(callByDoctor(
                          conferenceID: "1",
                          userid: doctor.userID,
                          username: doctor.firstName + " " + doctor.lastName,
                        ));
                      },
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

class AfterAppointmentViewCard extends StatelessWidget {
  const AfterAppointmentViewCard({
    required this.patientName,
    required this.startTime,
    required this.endTime,
    required this.day,
    required this.patientID,
    required this.doctorID,
    Key? key,
    required this.fees,
  }) : super(key: key);
  final String patientName;
  final String startTime;
  final String patientID;
  final String doctorID;

  final String fees;
  final String endTime;
  final String day;
  @override
  Widget build(BuildContext context) {
    final doctorController = Get.find<DoctorController>();

    doctorController.getDoctorById(FirebaseAuth.instance.currentUser!.uid);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: getProportionateScreenHeight(160),
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(10),
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
                        Text(day.toString()),
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
              Container(
                height: getProportionateScreenHeight(40),
                width: getProportionateScreenWidth(200),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    // side: BorderSide(
                    //   width: getProportionateScreenWidth(1).0,
                    //   color: Colors.blueAccent,
                    // ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Appointment Completed',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BeforeAppointmentViewCard extends StatelessWidget {
  const BeforeAppointmentViewCard({
    required this.patientName,
    required this.startTime,
    required this.endTime,
    required this.day,
    required this.patientID,
    required this.doctorID,
    Key? key,
    required this.fees,
  }) : super(key: key);
  final String patientName;
  final String startTime;
  final String patientID;
  final String doctorID;

  final String fees;
  final String endTime;
  final String day;
  @override
  Widget build(BuildContext context) {
    final doctorController = Get.find<DoctorController>();

    doctorController.getDoctorById(FirebaseAuth.instance.currentUser!.uid);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: getProportionateScreenHeight(190),
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(10),
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
                        Text(day.toString()),
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
              Container(
                height: getProportionateScreenHeight(40),
                width: getProportionateScreenWidth(250),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    // side: BorderSide(
                    //   width: getProportionateScreenWidth(1).0,
                    //   color: Colors.blueAccent,
                    // ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Appointment Pending',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

bool checkTime(
    {required String day,
    required int startHour,
    required int endHour,
    required int startMinute,
    required int endMinute}) {
  DateTime now = DateTime.now();
  bool temp = false;
  final List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  print(startHour);
  print(endHour);
  print(startMinute);
  print(endMinute);
  print(day);
  print(daysOfWeek[now.weekday - 1]);
  print(now.hour);
  print(now.minute);
  if (daysOfWeek[now.weekday - 1] == day) {
    if (now.hour >= startHour && now.hour <= endHour) {
      if (now.hour >= startHour &&
          now.minute >= startMinute &&
          now.hour <= endHour &&
          now.minute <= endMinute) {
        temp = true;
      }
    }
  }

  return temp;
}
