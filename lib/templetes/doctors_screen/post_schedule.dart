import 'package:doctorandpatient/core/colors.dart';
import 'package:doctorandpatient/core/utils.dart';
import 'package:doctorandpatient/templetes/doctors_screen/doctor_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/doctor_schedule_controlller.dart';
import '../../core/size_configuration.dart';

class PostSchedule extends StatefulWidget {
  const PostSchedule({super.key});

  @override
  State<PostSchedule> createState() => _PostScheduleState();
}

class _PostScheduleState extends State<PostSchedule> {
  final databaseRef = FirebaseDatabase.instance.ref("Doctor Schedule");
  TimeOfDay startTime = TimeOfDay(hour: 10, minute: 30);
  TimeOfDay endTime = TimeOfDay(hour: 10, minute: 30);
  TextEditingController feeController = TextEditingController();
  bool toggle = false;
  final scheduleController = Get.put(DoctorSchedulesController());
  bool loading = false;
  DateTime scheduleDate = DateTime(22);

  // List days = [
  //   "Monday",
  //   "Tuesday",
  //   "Wednesday",
  //   "Thursday",
  //   "Firday",
  //   "Saturday",
  //   "Sunday"
  // ];
  // List DropDownListData = [
  //   {"title": "Monday", "value": "1"},
  //   {"title": "Tuesday", "value": "2"},
  //   {"title": "Wednesday", "value": "3"},
  //   {"title": "Thursday", "value": "4"},
  //   {"title": "Firday", "value": "5"},
  //   {"title": "Saturday", "value": "6"},
  //   {"title": "Sunday", "value": "7"}
  // ];
  // String defaultValue = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            // leading: GestureDetector(
            //     onTap: () {
            //       Get.off(DoctorScheduleHistory());
            //     },
            //     child: Icon(Icons.arrow_back)),
            backgroundColor: Colors.red,
            title: Text(
              "Post Schedule",
            )),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Center(
                  child: Text(
                "Date:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              )),
              TextButton(
                  onPressed: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime
                          .now(), // Set the initial date to display in the picker
                      firstDate:
                          DateTime.now(), // Set the minimum date selectable
                      lastDate: DateTime(
                          2025, 04, 29), // Set the maximum date selectable
                    );

                    if (pickedDate != null) {
                      setState(() {
                        scheduleDate = pickedDate;
                      });
                    }
                  },
                  child: Text(
                    scheduleDate.year == 22
                        ? 'Select'
                        : "${scheduleDate.day}/${scheduleDate.month}/${scheduleDate.year}",
                    style: const TextStyle(color: Colors.blue, fontSize: 24),
                  )),
              Center(
                  child: Text(
                "Start Time:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              )),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Text(
                "${startTime.hour}:${startTime.minute}",
                style: TextStyle(fontSize: 32),
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  onPressed: (() async {
                    TimeOfDay? newTime = await showTimePicker(
                        context: context, initialTime: startTime);

                    if (newTime == null) return;
                    setState(() {
                      startTime = newTime;
                    });
                  }),
                  child: Text("Select Time")),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Text(
                "End Time",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: getProportionateScreenHeight(4),
              ),
              Text(
                "${endTime.hour}:${endTime.minute}",
                style: TextStyle(fontSize: 32),
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  onPressed: (() async {
                    TimeOfDay? newTime2 = await showTimePicker(
                        context: context, initialTime: startTime);

                    if (newTime2 == null) return;
                    setState(() {
                      endTime = newTime2;
                    });
                  }),
                  child: Text("Select Time")),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Text(
                "Fees",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Center(
                child: Container(
                  width: getProportionateScreenWidth(200),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: feeController,
                    decoration: InputDecoration(
                      hintText: "Fees Structure",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: getProportionateScreenWidth(3),
                            color: AppColors.btnlogingreyGreen),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(80),
              ),
              SizedBox(
                height: getProportionateScreenHeight(40),
                width: getProportionateScreenWidth(250),
                //   width: getProportionateScreenWidth(1)50,
                child: ElevatedButton(
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
                  onPressed: () {
                    setState(() {
                      loading = true;
                    });

                    scheduleController.uploadData(
                        startTime: startTime.hour.toString() +
                            ":" +
                            startTime.minute.toString(),
                        endTime: endTime.hour.toString() +
                            ":" +
                            endTime.minute.toString(),
                        date: scheduleDate,
                        docID: FirebaseAuth.instance.currentUser!.uid,
                        fees: feeController.text);
                    scheduleController.fetchData();
                    Get.back();
                    Utils().toastMessage("Post Added");

                    //  Get.off(DoctorScheduleHistory());
                  },
                  child: Text(
                    'submit',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: ListView(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     children: [
//                       InputDecorator(
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(15)),
//                             contentPadding: EdgeInsets.all(10)),
//                         child: DropdownButtonHideUnderline(
//                           child: DropdownButton(
//                             isDense: true,
//                             isExpanded: true,
//                             value: defaultValue,
//                             items: [
//                               DropdownMenuItem(
//                                 child: Text('Select Categry'),
//                                 value: "",
//                               ),
//                               ...DropDownListData.map<DropdownMenuItem<String>>(
//                                   (data) {
//                                 return DropdownMenuItem(
//                                     child: Text(data['title']),
//                                     value: data['value']);
//                               }).toList(),
//                             ],
//                             onChanged: (value) {
//                               print("selected Value $value");

//                               setState(() {
//                                 defaultValue = value!;
//                               });
//                             },
//                           ),
//                         ),
//                       )
//                     ]),
//               ),