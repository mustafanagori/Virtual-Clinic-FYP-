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

final scheduleController = Get.find<DoctorSchedulesController>();

class _DoctorScheduleHistoryState extends State<DoctorScheduleHistory> {
  Future<void> _refresh() async {
    // Simulate a delay for fetching new data

    await scheduleController.fetchData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final doctorsSchedule = scheduleController.getList.where((element) =>
        element.doctorID == FirebaseAuth.instance.currentUser!.uid);

    scheduleController.fetchData();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
        
          backgroundColor: Colors.red,
          title: const Text(
            "Doctor's Schedule History",
            style: TextStyle(fontSize: 22),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  Get.to(const PostSchedule());
                },
                child: const Row(
                  children: [
                    Icon(Icons.add),
                  ],
                ),
              ),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: SizedBox(
            height: getProportionateScreenHeight(670),
            width: getProportionateScreenWidth(400),
            child: GetBuilder<DoctorSchedulesController>(builder: (controller) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: doctorsSchedule.length,
                itemBuilder: (context, index) => DoctorCategoryCard(
                  onPressedDelete: () async {
                    await scheduleController.deleteData(
                        userID: doctorsSchedule.elementAt(index).userID);
                    Utils().toastMessage("Schedule Deleted");
                  },
                  day: doctorsSchedule.elementAt(index).day,
                  endTime: doctorsSchedule.elementAt(index).endTime.toString(),
                  fees: doctorsSchedule.elementAt(index).fees,
                  startTime:
                      doctorsSchedule.elementAt(index).startTime.toString(),
                ),
              );
            }),
          ),
        ));
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
              boxShadow: const [
                BoxShadow(color: Colors.red, spreadRadius: 2),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                "StartTiming:",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(2),
                              ),
                              Text(startTime,
                                  style: const TextStyle(fontSize: 20)),
                              SizedBox(
                                width: getProportionateScreenWidth(1),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text("EndTiming:",
                                  style: TextStyle(fontSize: 20)),
                              SizedBox(
                                width: getProportionateScreenWidth(2),
                              ),
                              Text(endTime,
                                  style: const TextStyle(fontSize: 20)),
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
                      Text("Day ", style: const TextStyle(fontSize: 20)),
                      SizedBox(
                        width: getProportionateScreenWidth(
                          2,
                        ),
                      ),
                      Text(day.toString(),
                          style: const TextStyle(fontSize: 20)),
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
                      const Text("Fees ", style: TextStyle(fontSize: 20)),
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
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
            child: IconButton(
                onPressed: onPressedDelete,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 40,
                )),
          )
        ]),
      ],
    );
  }
}
