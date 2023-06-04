import 'package:doctorandpatient/controller/bottom_bar_controller.dart';
import 'package:doctorandpatient/core/colors.dart';
// ignore: unused_import
import 'package:doctorandpatient/templetes/patient_screen/pateint_myprofile.dart';
import 'package:doctorandpatient/templetes/patient_screen/patient_home.dart';
import 'package:doctorandpatient/templetes/patient_screen/take_appointment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/bottom_bar_Patient_controller.dart';

// ignore: must_be_immutable
class PatientDashboard extends StatelessWidget {
  PatientDashboard({Key? key}) : super(key: key);

  BottomBarPatientController barPatientController =
      Get.put(BottomBarPatientController());

  @override
  Widget build(BuildContext context) {
    // return GetBuilder<BottomNavBarController>(
    //     // init: BottomNavBarController(),
    //     builder: (barController) {
    return Obx(
      () => Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: IndexedStack(
            index: barPatientController.selectedIndex.value,
            children: [PatientHome(), TakeAppointment(), mypProfile()],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          unselectedItemColor: AppColors.btnlogingreyGreen,
          selectedItemColor: Colors.red,
          currentIndex: barPatientController.selectedIndex.value > 0
              ? barPatientController.selectedIndex.value
              : 0,
          onTap: barPatientController.changeTabIndex,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'Assets/home.png',
                scale: 4,
                color: Colors.black,
              ),
              activeIcon: Image.asset(
                'Assets/home3.png',
                scale: 4,
                // color: kRedLogin,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'Assets/profile2.png',
                scale: 4,
                color: Colors.black,
              ),
              label: "Take Appointment",
              activeIcon: Image.asset(
                'Assets/profile3.png',
                scale: 4,
                //  color: kRedLogin,
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'Assets/profile2.png',
                scale: 4,
                color: Colors.black,
              ),
              label: "Profile",
              activeIcon: Image.asset(
                'Assets/profile3.png',
                scale: 4,
                //  color: kRedLogin,
              ),
            ),
          ],
        ),
      ),
      // },
    );
  }
}
