import 'dart:ffi';

import 'package:doctorandpatient/core/size_configuration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jazzcash_flutter/jazzcash_flutter.dart';

import '../../controller/doctor_schedule_controlller.dart';
import '../../controller/doctors_controller.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}


class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String paymentStatus = "pending";
  ProductModel productModel = ProductModel("DR Fee ", "200");
  String integritySalt = "17vt285ytb";
  String merchantID = "MC57097";
  String merchantPassword = "u0w0953419";
  String transactionUrl =
      "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction";
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("JazzCash Flutter Example"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Product Name : ${productModel.productName}"),
            Text("Product Price : ${productModel.productPrice}"),
            SizedBox(
              height: getProportionateScreenHeight(220),
            ),
            Container(
              height: getProportionateScreenHeight(50),
              width: getProportionateScreenWidth(160),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed: () {
                    _payViaJazzCash(productModel, context);
                  },
                  child: const Text(
                    "Purchase Now !",
                    style: TextStyle(fontSize: 20),
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
        ppAmount: '${element.productPrice}',
        ppBillReference:
            'refbill${date.year}${date.month}${date.day}${date.hour}${date.millisecond}',
        ppDescription:
            'Product details  ${element.productName} - ${element.productPrice}',
        ppMerchantID: merchantID,
        ppPassword: merchantPassword,
        ppReturnURL: transactionUrl,
      );

      jazzCashFlutter
          .startPayment(
              paymentDataModelV1: paymentDataModelV1, context: context)
          .then((_response) {
        print("response from jazzcash $_response");

        // _checkIfPaymentSuccessfull(_response, element, context).then((res) {
        //   // res is the response you returned from your return url;
        //   return res;
        // });

        setState(() {});
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
  String? productName;
  String? productPrice;

  ProductModel(this.productName, this.productPrice);
}
