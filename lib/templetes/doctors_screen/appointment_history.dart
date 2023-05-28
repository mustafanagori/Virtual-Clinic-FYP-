import 'package:doctorandpatient/controller/doctors_controller.dart';
import 'package:doctorandpatient/controller/patient_controller.dart';
import 'package:doctorandpatient/core/colors.dart';
import 'package:doctorandpatient/templetes/patient_screen/rating.dart';
import 'package:doctorandpatient/templetes/patient_screen/viewpresiption.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/create_appoint.dart';
import '../../controller/doctor_schedule_controlller.dart';
import '../../core/size_configuration.dart';
import '../../Chat/chat_inbox.dart';
import '../video_Calling/call.dart';

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

                return dataList.elementAt(index).status == "book"
                    ? AppointtmentViewCard(
                        fees: data.fees,
                        onPressedReject: () async {
                          await caController.updateStatus(
                              dataList.elementAt(index).sheduleID, "Rejected");
                        },
                        onPressedAccept: () async {
                          await caController.updateStatus(
                              dataList.elementAt(index).sheduleID, "Accepted");
                        },
                        date: data.date,
                        endTime: data.endTime,
                        patientName: patientController
                            .getPatientById(dataList.elementAt(index).patientID)
                            .name,
                        startTime: data.startTime,
                      )
                    : AppointtmentAcceptedViewCard(
                        patientID: dataList.elementAt(index).patientID,
                        doctorID: data.doctorID,
                        fees: data.fees,
                        date: data.date,
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
    required this.date,
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
  final DateTime date;
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
  final String patientID;
  final String doctorID;

  final String fees;
  final String endTime;
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    final doctorController = Get.find<DoctorController>();
    final doctor = doctorController.getDoctorById(FirebaseAuth.instance.currentUser!.uid);
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
                        'Presiption',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    height: getProportionateScreenHeight(40),
                    width: getProportionateScreenWidth(100),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(MYcall(
                          conferenceID: "1",
                          userid:doctor.userID,
                          username: doctor.firstName + " " +doctor.lastName,
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
