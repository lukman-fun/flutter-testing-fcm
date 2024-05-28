import 'package:flutter/material.dart';
import 'package:testing/presentations/attendance/attendance_card.dart';
import 'package:testing/utils/ColorAsset.dart';

class AttendanceFacePage extends StatefulWidget {
  const AttendanceFacePage({super.key});

  @override
  State<AttendanceFacePage> createState() => _AttendanceFacePageState();
}

class _AttendanceFacePageState extends State<AttendanceFacePage> {
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
              // attendanceCard(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width - 100,
              height: MediaQuery.of(context).size.width - 100,
              margin: const EdgeInsets.only(top: 16),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(1000),
                border: const Border(
                  left: BorderSide(
                    color: ColorAsset.GREEN,
                    width: 8,
                  ),
                  top: BorderSide(
                    color: ColorAsset.GREEN,
                    width: 8,
                  ),
                  right: BorderSide(
                    color: ColorAsset.GREEN,
                    width: 8,
                  ),
                  bottom: BorderSide(
                    color: ColorAsset.GREEN,
                    width: 8,
                  ),
                ),
                // image: DecorationImage(
                //   image: AssetImage('assets/decorations/profile.png'),
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
          ),
          Container(
            width: 200,
            margin: const EdgeInsets.only(top: 16),
            child: const Text(
              'Posisikan wajah Anda di dalam lingkaran',
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

// void attendanceCard(BuildContext context) {
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
//       return const AttendanceCardPage();
//     },
//   );
// }
