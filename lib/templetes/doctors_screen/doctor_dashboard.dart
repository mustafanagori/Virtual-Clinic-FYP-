import 'package:doctorandpatient/core/colors.dart';
// ignore: unused_import

import 'package:doctorandpatient/templetes/doctors_screen/appointment_view.dart';
import 'package:doctorandpatient/templetes/doctors_screen/doctorhome.dart';
import 'package:doctorandpatient/templetes/doctors_screen/doctorschedule.dart';
import 'package:doctorandpatient/templetes/doctors_screen/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/bottom_bar_controller.dart';

// ignore: must_be_immutable
class DoctorDashboard extends StatelessWidget {
  DoctorDashboard({Key? key}) : super(key: key);

  BottomNavBarController barController = Get.put(BottomNavBarController());

  @override
  Widget build(BuildContext context) {
    // return GetBuilder<BottomNavBarController>(
    //     // init: BottomNavBarController(),
    //     builder: (barController) {
    print(FirebaseAuth.instance.currentUser!.uid);

    return Obx(
      () => Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: IndexedStack(
            index: barController.selectedIndex.value,
            children: [
              home_doctor(),
              DoctorScheduleHistory(),
              AppointmentScreen(),
              DoctorProfile()

              // PatientReportSearchView(),
              // const AppointmentScreen(),
              //  const profilePt(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          unselectedItemColor: AppColors.btnlogingreyGreen,
          selectedItemColor: Colors.red,
          currentIndex: barController.selectedIndex.value,
          onTap: barController.changeTabIndex,
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
                'Assets/report.png',
                scale: 4,
                color: Colors.black,
              ),
              label: " Sehedule",
              //   backgroundColor: Colors.red,
              activeIcon: Image.asset(
                'Assets/report3.png',
                scale: 4,
                //  color: kRedLogin,
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'Assets/appointment.png',
                scale: 4,
                color: Colors.black,
              ),
              label: "Appointments",
              activeIcon: Image.asset(
                'Assets/appointment3.png',
                scale: 4,
                // color: kRedLogin,
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
