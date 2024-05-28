import 'package:flutter/material.dart';
import 'package:testing/utils/ColorAsset.dart';

class AttendanceSuccessPage extends StatefulWidget {
  const AttendanceSuccessPage({super.key});

  @override
  State<AttendanceSuccessPage> createState() => _AttendanceSuccessPageState();
}

class _AttendanceSuccessPageState extends State<AttendanceSuccessPage> {
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
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width - 150,
              height: MediaQuery.of(context).size.width - 150,
              margin: const EdgeInsets.only(top: 16),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/decorations/success.png'),
                ),
              ),
            ),
          ),
          Container(
            width: 200,
            margin: const EdgeInsets.only(top: 16),
            child: const Text(
              'Absensi berhasil!',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: ColorAsset.GREEN,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
