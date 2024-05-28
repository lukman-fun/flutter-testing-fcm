import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing/presentations/schedule/schedule_exam.dart';
import 'package:testing/presentations/schedule/schedule_kbm.dart';
import 'package:testing/utils/ColorAsset.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<Map<String, dynamic>> menus = [
    {
      'name': 'KBM',
      'isActive': true,
      'page': const ScheduleKbmPage(),
    },
    {
      'name': 'Ujian',
      'isActive': false,
      'page': const ScheduleExamPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal'),
        titleSpacing: 0,
        backgroundColor: ColorAsset.GREEN,
        leading: IconButton(
          onPressed: () {
            // Navigator.pop(context);
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            color: ColorAsset.GREEN,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: menus.map(
                (val) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ElevatedButton(
                      onPressed: () {
                        for (var item in menus) {
                          item['isActive'] = false;
                        }

                        setState(() {
                          val['isActive'] = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: val['isActive']
                            ? Colors.white
                            : ColorAsset.GREEN_DARK,
                        fixedSize: const Size(100, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        val['name'],
                        style: TextStyle(
                          color:
                              val['isActive'] ? ColorAsset.GREEN : Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          menus[0]['isActive']
              ? Expanded(child: menus[0]['page'])
              : const SizedBox(),
          menus[1]['isActive']
              ? Expanded(child: menus[1]['page'])
              : const SizedBox(),
        ],
      ),
    );
  }
}
