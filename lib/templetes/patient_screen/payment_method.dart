import 'package:doctorandpatient/core/size_configuration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jazzcash_flutter/jazzcash_flutter.dart';

import '../../controller/create_appoint.dart';
import '../../controller/doctor_schedule_controlller.dart';
import '../../controller/doctors_controller.dart';
import '../../core/utils.dart';
import '../../models/doctor_model.dart';
import '../../models/patient_model.dart';
import "../../models/doctor_scheduleModel.dart";

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen(
      {super.key,
      required this.doctorModel,
      required this.patientModel,
      required this.doctorScheduleModel});
  final DoctorModel doctorModel;
  final PatientModel patientModel;
  final DoctorScheduleModel doctorScheduleModel;
  @override
  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final appointmentController = Get.find<CreateAppointmentController>();
  final doctorController = Get.find<DoctorController>();
  final doctorscheduleController = Get.find<DoctorSchedulesController>();
  String paymentStatus = "pending";
  // ProductModel productModel =
  String integritySalt = "17vt285ytb";
  String merchantID = "MC57097";
  String merchantPassword = "u0w0953419";
  String transactionUrl =
      "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction";

  get index => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Jazz Cash"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Doctor Name : ${widget.doctorModel.firstName} ${widget.doctorModel.lastName}",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Doctor Account : ${widget.doctorModel.contact}",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Patient Name : ${widget.patientModel.name}",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Doctor Fee : ${widget.doctorScheduleModel.fees}",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 230,
            ),
            Container(
              height: getProportionateScreenHeight(50),
              width: getProportionateScreenWidth(160),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed: () async {
                    _payViaJazzCash(
                        ProductModel("DR Fee ",
                            widget.doctorScheduleModel.fees.toString()),
                        context);
                  },
                  child: const Text(
                    "Pay Dr Fee Now !",
                    style: TextStyle(fontSize: 18),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future _payViaJazzCash(ProductModel element, BuildContext c) async {
    // print("clicked on Product ${element.name}");

    try {
      JazzCashFlutter jazzCashFlutter = JazzCashFlutter(
        merchantId: merchantID,
        merchantPassword: merchantPassword,
        integritySalt: integritySalt,
        isSandbox: true,
      );

      DateTime date = DateTime.now();

      JazzCashPaymentDataModelV1 paymentDataModelV1 =
          JazzCashPaymentDataModelV1(
        ppAmount: '${element.Doctor_Fee}',
        ppBillReference:
            'refbill${date.year}${date.month}${date.day}${date.hour}${date.millisecond}',
        ppDescription:
            'Product details  ${element.Doctor_Name} - ${element.Doctor_Fee}',
        ppMerchantID: merchantID,
        ppPassword: merchantPassword,
        ppReturnURL: transactionUrl,
      );

      jazzCashFlutter
          .startPayment(
              paymentDataModelV1: paymentDataModelV1, context: context)
          .then((_response) async {
        print("response from jazzcash $_response");

        // _checkIfPaymentSuccessfull(_response, element, context).then((res) {
        //   // res is the response you returned from your return url;
        //   return res;
        // });
        await appointmentController.uploadData(
            status: "book",
            patientID: widget.patientModel.userID,
            doctorID: widget.doctorModel.userID,
            sheduleID: widget.doctorScheduleModel.userID);

        await appointmentController.fetchData();
        Utils().toastMessage("BOOKED");

        setState(() {});
        Get.back();
      });
    } catch (err) {
      print("Error in payment $err");
      // CommonFunctions.CommonToast(
      //   message: "Error in payment $err",
      // );
      return false;
    }
  }
}

class ProductModel {
  String? Doctor_Name;
  String? Doctor_Fee;

  ProductModel(this.Doctor_Name, this.Doctor_Fee);
}
