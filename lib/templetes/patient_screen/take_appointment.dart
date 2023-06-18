import 'package:doctorandpatient/models/doctor_model.dart';
import 'package:doctorandpatient/models/doctor_scheduleModel.dart';
import 'package:doctorandpatient/templetes/patient_screen/payment_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../controller/create_appoint.dart';
import '../../controller/doctor_schedule_controlller.dart';
import '../../controller/doctors_controller.dart';
import '../../controller/patient_controller.dart';
import '../../core/size_configuration.dart';
import '../../core/utils.dart';

class TakeAppointment extends StatefulWidget {
  const TakeAppointment({Key? key}) : super(key: key);

  @override
  State<TakeAppointment> createState() => _TakeAppointmentState();
}

TextEditingController search = TextEditingController();
final scheduleController = Get.put(DoctorSchedulesController());
final appointmentController = Get.put(CreateAppointmentController());
final docController = Get.put(DoctorController());

final patientController = Get.put(PatientController());

// fun for rating
double _rating(List<dynamic>? rating) {
  List<double> doubleList = [];

  rating?.forEach((element) {
    doubleList.add(double.parse(element.toString()));
  });

  double sum = 0;
  for (double r in doubleList) {
    sum += r;
  }
  return sum / doubleList.length;
}

class _TakeAppointmentState extends State<TakeAppointment> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController searchController = TextEditingController();
  // search funcation
  // search() {

  //   List<DoctorModel> docList = [];
  //   List<DoctorScheduleModel> schList = [];
  //   for (DoctorModel c in docController.getList) {
  //     if (c.firstName
  //             .toLowerCase()
  //             .trim()
  //             .contains(searchController.text.toLowerCase().trim()) ||
  //         c.lastName
  //             .toLowerCase()
  //             .trim()
  //             .contains(searchController.text.toLowerCase().trim())) {
  //       docList.add(c);
  //     }
  //   }
  //   for (DoctorModel doctor in docList) {
  //     for (DoctorScheduleModel sch
  //         in scheduleController.getData(appointmentController.getList)) {
  //       if (sch.doctorID == doctor.userID) {
  //         schList.add(sch);
  //       }
  //     }
  //   }

  //   return schList;
  // }
  // search by speclization
  search() {
    List<DoctorModel> docList = [];
    List<DoctorScheduleModel> schList = [];
    for (DoctorModel c in docController.getList) {
      if (c.spealization
          .toLowerCase()
          .trim()
          .contains(searchController.text.toLowerCase().trim())) {
        docList.add(c);
      }
    }
    for (DoctorModel doctor in docList) {
      for (DoctorScheduleModel sch
          in scheduleController.getData(appointmentController.getList)) {
        if (sch.doctorID == doctor.userID) {
          schList.add(sch);
        }
      }
    }

    return schList;
  }

  @override
  Widget build(BuildContext context) {
    List<DoctorScheduleModel> doctorsSchedule = searchController.text.isNotEmpty
        ? search()
        : scheduleController.getData(appointmentController.getList);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                image: AssetImage(
                    'Assets/sl-telehealth-smartphone-doctor-1200x600.jpeg'),
                height: getProportionateScreenHeight(180),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Doctor Appointment +',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: getProportionateScreenWidth(3),
                              color: Colors.red),
                          borderRadius: BorderRadius.circular(20)),
                      labelText: "Search....."),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              SizedBox(
                height: getProportionateScreenHeight(430),
                width: getProportionateScreenWidth(350),
                child: GetBuilder<DoctorSchedulesController>(
                    builder: (controller) {
                  return ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(height: getProportionateScreenHeight(0)),
                    itemCount: doctorsSchedule.length,
                    itemBuilder: (context, index) => DoctorScheduleCard(
                      rat: _rating(docController
                          .getDoctorById(doctorsSchedule[index].doctorID)
                          .rating),
                      speacialization: docController
                          .getDoctorById(doctorsSchedule[index].doctorID)
                          .spealization,
                      onPressed: () async {
                        Get.to(PaymentMethodScreen(
                          doctorScheduleModel: doctorsSchedule[index],
                          doctorModel: docController
                              .getDoctorById(doctorsSchedule[index].doctorID),
                          patientModel: patientController.getPatientById(
                              FirebaseAuth.instance.currentUser!.uid),
                        ));
                        //------------------
                        // await appointmentController.uploadData(
                        //     status: "book",
                        //     patientID: FirebaseAuth.instance.currentUser!.uid,
                        //     doctorID: docController
                        //         .getDoctorById(doctorsSchedule[index].doctorID)
                        //         .userID,
                        //     sheduleID: doctorsSchedule.elementAt(index).userID);

                        await appointmentController.fetchData();
                        Utils().toastMessage("Request Sent");
                        setState(() {});
                      },
                      day: doctorsSchedule[index].day,
                      endTime: doctorsSchedule[index].endTime.toString(),
                      fees: doctorsSchedule[index].fees,
                      name: docController
                              .getDoctorById(doctorsSchedule[index].doctorID)
                              .firstName +
                          " " +
                          docController
                              .getDoctorById(doctorsSchedule[index].doctorID)
                              .lastName,
                      startTime: doctorsSchedule[index].startTime.toString(),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DoctorScheduleCard extends StatelessWidget {
  const DoctorScheduleCard({
    required this.speacialization,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.fees,
    required this.day,
    required this.rat,
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final String speacialization;
  final void Function()? onPressed;
  final String name;
  final String startTime;
  final String endTime;
  final String fees;
  final String day;
  final double rat;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: getProportionateScreenHeight(220),
          width: getProportionateScreenWidth(300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.red, spreadRadius: 2),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Row(
                      children: [
                        Text(
                          "Dr Name: ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(20),
                        ),
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Row(
                      children: [
                        Text(
                          "Date:",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(20),
                        ),
                        Text(day.toString().split(" ")[0]),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Dr Fee:", style: TextStyle(fontSize: 15)),
                        SizedBox(
                          width: getProportionateScreenWidth(20),
                        ),
                        Text(fees),
                        SizedBox(
                          width: getProportionateScreenWidth(10),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "StartTime",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(20),
                        ),
                        Text(startTime),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "EndTime",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(20),
                        ),
                        Text(endTime),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(6),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            "Spec:",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(20),
                          ),
                          Text(
                            speacialization,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: rat,
                          minRating: 0,
                          ignoreGestures: true,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  left: 240,
                  top: 55,
                  child: SizedBox(
                    height: getProportionateScreenHeight(50),
                    width: getProportionateScreenWidth(90),
                    //   width: getProportionateScreenWidth(15)0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: onPressed,
                      child: Text(
                        'Book ',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
