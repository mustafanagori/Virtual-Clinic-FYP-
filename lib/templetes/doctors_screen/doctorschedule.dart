import 'package:doctorandpatient/templetes/doctors_screen/post_schedule.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/doctor_schedule_controlller.dart';
import '../../core/size_configuration.dart';
import '../../core/utils.dart';

class DoctorScheduleHistory extends StatefulWidget {
  const DoctorScheduleHistory({super.key});

  @override
  State<DoctorScheduleHistory> createState() => _DoctorScheduleHistoryState();
}

final scheduleController = Get.put(DoctorSchedulesController());

class _DoctorScheduleHistoryState extends State<DoctorScheduleHistory> {
  @override
  Widget build(BuildContext context) {
    scheduleController.fetchData();
    final doctorsSchedule = scheduleController.getList.where((element) =>
        element.doctorID == FirebaseAuth.instance.currentUser!.uid);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Doctor Schedule History",
          // style: TextStyle(: .red),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Get.to(PostSchedule());
              },
              child: Row(
                children: [
                  Icon(Icons.add),
                ],
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(670),
              width: getProportionateScreenWidth(400),
              child:
                  GetBuilder<DoctorSchedulesController>(builder: (controller) {
                return ListView.builder(
                  itemCount: doctorsSchedule.length,
                  itemBuilder: (context, index) => DoctorCategoryCard(
                    onPressedDelete: () async {
                      await scheduleController.deleteData(
                          userID: doctorsSchedule.elementAt(index).userID);
                      Utils().toastMessage("Schedule Deleted");
                    },
                    day: doctorsSchedule.elementAt(index).day,
                    endTime:
                        doctorsSchedule.elementAt(index).endTime.toString(),
                    fees: doctorsSchedule.elementAt(index).fees,
                    startTime:
                        doctorsSchedule.elementAt(index).startTime.toString(),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorCategoryCard extends StatelessWidget {
  const DoctorCategoryCard({
    required this.onPressedDelete,
    required this.startTime,
    required this.endTime,
    required this.fees,
    required this.day,
    Key? key,
  }) : super(key: key);
  final void Function()? onPressedDelete;
  final String startTime;
  final String endTime;
  final String fees;
  final String day;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: getProportionateScreenHeight(150),
            width: getProportionateScreenWidth(800),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.red, spreadRadius: 2),
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "StartTiming:",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(2),
                              ),
                              Text(startTime, style: TextStyle(fontSize: 20)),
                              SizedBox(
                                width: getProportionateScreenWidth(1),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("EndTiming:",
                                  style: TextStyle(fontSize: 20)),
                              SizedBox(
                                width: getProportionateScreenWidth(2),
                              ),
                              Text(endTime, style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(6),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text("Day ", style: TextStyle(fontSize: 20)),
                      SizedBox(
                        width: getProportionateScreenWidth(
                          2,
                        ),
                      ),
                      Text(day.toString(), style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text("Fees ", style: TextStyle(fontSize: 20)),
                      SizedBox(
                        width: getProportionateScreenWidth(2),
                      ),
                      Text(fees, style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(children: [
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: IconButton(
                onPressed: onPressedDelete,
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 50,
                )),
          )
        ]),
      ],
    );
  }
}
