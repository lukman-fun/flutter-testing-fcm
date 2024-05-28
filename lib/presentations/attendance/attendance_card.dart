import 'package:flutter/material.dart';
import 'package:testing/presentations/attendance/attendance_success.dart';

class AttendanceCardPage extends StatefulWidget {
  const AttendanceCardPage({super.key});

  @override
  State<AttendanceCardPage> createState() => _AttendanceCardPageState();
}

class _AttendanceCardPageState extends State<AttendanceCardPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 120,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(100),
            ),
            margin: const EdgeInsets.only(bottom: 24),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 24),
            child: const Text(
              'Pegang Hp dengan tegak',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.grey,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigator.pop(context);
              // attendanceSuccess(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width - 150,
              height: MediaQuery.of(context).size.width - 150,
              margin: const EdgeInsets.only(top: 16),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/decorations/nfc.png'),
                ),
              ),
            ),
          ),
          Container(
            width: 200,
            margin: const EdgeInsets.only(top: 16),
            child: const Text(
              'Letakkan kartu Anda di dekat perangkat',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

// void attendanceSuccess(BuildContext context) {
//   showModalBottomSheet(
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(32),
//         topRight: Radius.circular(32),
//       ),
//     ),
//     context: context,
//     isScrollControlled: true,
//     builder: (context) {
//       return const AttendanceSuccessPage();
//     },
//   );
// }
