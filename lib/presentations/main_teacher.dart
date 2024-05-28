import 'package:flutter/material.dart';
import 'package:testing/presentations/attendance/attendance_face.dart';
import 'package:testing/presentations/attendance/attendance_history.dart';
import 'package:testing/presentations/home/home_parent.dart';
import 'package:testing/presentations/home/home_student.dart';
import 'package:testing/presentations/home/home_teacher.dart';
import 'package:testing/presentations/report/report.dart';
import 'package:testing/utils/ColorAsset.dart';
import 'package:testing/utils/session_auth.dart';

class MainTeacherPage extends StatefulWidget {
  const MainTeacherPage({super.key});

  @override
  State<MainTeacherPage> createState() => _MainTeacherPageState();
}

class _MainTeacherPageState extends State<MainTeacherPage> {
  List menus = [
    const HomeTeacherPage(),
    const AttendanceHistoryPage(),
  ];

  int selectedMenu = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   backgroundColor: Colors.grey[300],
      //   title: Text(
      //     'Assalamualaikum,',
      //     style: TextStyle(
      //       color: Colors.black,
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: Icon(Icons.notifications_none_rounded),
      //       color: Colors.black,
      //     )
      //   ],
      //   elevation: 0,
      // ),
      body: menus[selectedMenu],
      // body: menus[selectedMenu],
      // floatingActionButton: SizedBox(
      //   width: 70,
      //   height: 70,
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       attendanceFace(context);
      //     },
      //     child: Icon(
      //       Icons.person,
      //       size: 36,
      //     ),
      //     backgroundColor: ColorAsset.GREEN,
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        // fixedColor: ColorAsset.GREEN,
        selectedItemColor: ColorAsset.GREEN,
        onTap: (value) {
          setState(() {
            selectedMenu = value;
          });
        },
        currentIndex: selectedMenu,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.nfc_rounded),
            label: 'Absensi',
          ),
        ],
      ),
    );
  }
}

void attendanceFace(BuildContext context) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      ),
    ),
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return const AttendanceFacePage();
    },
  );
}
