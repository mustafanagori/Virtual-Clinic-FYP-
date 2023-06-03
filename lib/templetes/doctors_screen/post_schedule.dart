import 'package:doctorandpatient/core/colors.dart';
import 'package:doctorandpatient/core/utils.dart';
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
  TimeOfDay startTime = TimeOfDay(hour: 09, minute: 00);
  TimeOfDay endTime = TimeOfDay(hour: 09, minute: 00);
  TextEditingController feeController = TextEditingController();
  bool toggle = false;
  final scheduleController = Get.put(DoctorSchedulesController());
  bool loading = false;
  String selectedDay = "Monday";
  final List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

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
                "Days:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              )),
              //   add dropdown list
              SizedBox(
                height: getProportionateScreenHeight(100),
                width: getProportionateScreenWidth(300),
                child: Center(
                  child: DropdownButton<String>(
                    focusColor: Colors.red,
                    value: selectedDay,
                    hint: Text('Select a day'),
                    onChanged: (value) {
                      setState(() {
                        selectedDay = value!;
                      });
                    },
                    items: daysOfWeek
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              // Text(
              //   'Sel
              //ected Day:',
              //   style: TextStyle(fontSize: 20),
              // ),
              // SizedBox(height: 10),
              // Text(
              //   selectedDay ?? 'No day selected',
              //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              // ),
              // SizedBox(height: 20),
              // DropdownButton<String>(
              //   value: selectedDay,
              //   hint: Text('Select a day'), // Placeholder text
              //   onChanged: (newValue) {
              //     setState(() {
              //       selectedDay = newValue;
              //     });
              //   },
              //   items: days.map((String day) {
              //     return DropdownMenuItem<String>(
              //       value: day,
              //       child: Text(day),
              //     );
              //   }).toList(),
              // ),

              //     changed
              // TextButton(
              //     onPressed: () async {
              //       final DateTime? pickedDate = await showDatePicker(
              //         context: context,
              //         initialDate: DateTime
              //             .now(), // Set the initial date to display in the picker
              //         firstDate:
              //             DateTime.now(), // Set the minimum date selectable
              //         lastDate: DateTime(
              //             2025, 04, 29), // Set the maximum date selectable
              //       );

              //       if (pickedDate != null) {
              //         setState(() {
              //           scheduleDate = pickedDate;
              //         });
              //       }
              //     },
              //     child: Text(
              //       scheduleDate.year == 22
              //           ? 'Select'
              //           : "${scheduleDate.day}/${scheduleDate.month}/${scheduleDate.year}",
              //       style: const TextStyle(color: Colors.blue, fontSize: 24),
              //     )),
              Center(
                  child: Text(
                "Start Time:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              )),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Text(
                startTime.minute == 0
                    ? "${startTime.hour}:${startTime.minute}0"
                    : "${startTime.hour}:${startTime.minute}",
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
                    TimeOfDay? newTime = await showQuarterTimePicker(
                      context: context,
                      initialTime: startTime,
                    );

                    if (newTime == null) return;
                    setState(() {
                      startTime = newTime;
                      print(startTime);
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
                endTime.minute == 0
                    ? "${endTime.hour}:${endTime.minute}0"
                    : "${endTime.hour}:${endTime.minute}",
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
                    TimeOfDay? newTime2 = await showQuarterTimePicker(
                      context: context,
                      initialTime: endTime,
                    );
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
                    // TimeOfDay startTime = TimeOfDay(hour: 8, minute: 0);
                    // TimeOfDay endTime = TimeOfDay(hour: 17, minute: 0);
                    int intervalMinutes = 15;

                    List<TimeOfDay> slots =
                        generateTimeSlots(startTime, endTime, intervalMinutes);

                    for (TimeOfDay slot in slots) {
                      scheduleController.uploadData(
                          startTime: slot.toString().split("y")[1],
                          endTime: slot.minute + 15 == 60
                              ? TimeOfDay(hour: slot.hour + 1, minute: 0)
                                  .toString()
                                  .split("y")[1]
                              : TimeOfDay(
                                      hour: slot.hour, minute: slot.minute + 15)
                                  .toString()
                                  .split("y")[1],
                          day: selectedDay,
                          docID: FirebaseAuth.instance.currentUser!.uid,
                          fees: feeController.text);
                      scheduleController.fetchData();

                      print(slot.format(context));
                    }

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

Future<TimeOfDay?> showQuarterTimePicker({
  required BuildContext context,
  required TimeOfDay initialTime,
}) async {
  final TimeOfDay? pickedTime = await showDialog<TimeOfDay>(
    context: context,
    builder: (BuildContext context) {
      TimeOfDay? selectedTime = initialTime;

      return AlertDialog(
        title: Text('Select Time'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QuarterTimePicker(
              initialTime: initialTime,
              onTimeChanged: (TimeOfDay newTime) {
                selectedTime = newTime;
              },
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(selectedTime);
            },
          ),
        ],
      );
    },
  );

  return pickedTime;
}

class QuarterTimePicker extends StatefulWidget {
  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay> onTimeChanged;

  QuarterTimePicker({
    required this.initialTime,
    required this.onTimeChanged,
  });

  @override
  _QuarterTimePickerState createState() => _QuarterTimePickerState();
}

class _QuarterTimePickerState extends State<QuarterTimePicker> {
  late int _selectedMinutes;

  @override
  void initState() {
    super.initState();
    _selectedMinutes = widget.initialTime.hour * 60 + widget.initialTime.minute;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  _selectedMinutes -= 60;
                  if (_selectedMinutes < 0) {
                    _selectedMinutes = 24 * 60 + _selectedMinutes;
                  }
                  widget.onTimeChanged(_getTimeOfDay());
                });
              },
            ),
            Text(
              _getTimeOfDay().format(context),
              style: TextStyle(fontSize: 20),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  _selectedMinutes += 60;
                  if (_selectedMinutes >= 24 * 60) {
                    _selectedMinutes = _selectedMinutes - 24 * 60;
                  }
                  widget.onTimeChanged(_getTimeOfDay());
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  TimeOfDay _getTimeOfDay() {
    final int hour = _selectedMinutes ~/ 60;
    final int minute = _selectedMinutes % 60;
    return TimeOfDay(hour: hour, minute: minute);
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
List<TimeOfDay> generateTimeSlots(
    TimeOfDay startTime, TimeOfDay endTime, int intervalMinutes) {
  List<TimeOfDay> slots = [];
  TimeOfDay currentTime = startTime;

  while (_isTimeOfDayBeforeOrEqual(currentTime, endTime)) {
    slots.add(currentTime);
    currentTime = _addMinutesToTimeOfDay(currentTime, intervalMinutes);
  }

  return slots;
}

bool _isTimeOfDayBeforeOrEqual(TimeOfDay time1, TimeOfDay time2) {
  if (time1.hour < time2.hour) {
    return true;
  } else if (time1.hour == time2.hour && time1.minute < time2.minute) {
    return true;
  } else {
    return false;
  }
}

TimeOfDay _addMinutesToTimeOfDay(TimeOfDay time, int minutes) {
  int totalMinutes = time.hour * 60 + time.minute + minutes;
  int newHour = totalMinutes ~/ 60;
  int newMinute = totalMinutes % 60;

  return TimeOfDay(hour: newHour, minute: newMinute);
}
