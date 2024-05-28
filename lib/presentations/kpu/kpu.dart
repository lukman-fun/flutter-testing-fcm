import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing/presentations/kpu/pas.dart';
import 'package:testing/presentations/kpu/pts.dart';
import 'package:testing/utils/ColorAsset.dart';

class KpuPage extends StatefulWidget {
  const KpuPage({super.key});

  @override
  State<KpuPage> createState() => _KpuPageState();
}

class _KpuPageState extends State<KpuPage> {
  List<Map<String, dynamic>> menus = [
    {
      'name': 'PTS',
      'isActive': true,
      'page': const PtsPage(),
    },
    {
      'name': 'PAS',
      'isActive': false,
      'page': const PasPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kartu Peserta Ujian'),
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
