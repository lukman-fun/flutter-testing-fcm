import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:testing/blocs/schedule/kbm/kbm_bloc.dart';
import 'package:testing/blocs/schedule/kbm/kbm_event.dart';
import 'package:testing/blocs/schedule/kbm/kbm_state.dart';
import 'package:testing/blocs/schedule/teacher-kbm/kbm_bloc.dart';
import 'package:testing/blocs/schedule/teacher-kbm/kbm_event.dart';
import 'package:testing/blocs/schedule/teacher-kbm/kbm_state.dart';
import 'package:testing/domain/models/login_model.dart';
import 'package:testing/utils/ColorAsset.dart';
import 'package:testing/utils/session_auth.dart';

class ScheduleTeacherKbmPage extends StatefulWidget {
  const ScheduleTeacherKbmPage({super.key});

  @override
  State<ScheduleTeacherKbmPage> createState() => _ScheduleTeacherKbmPageState();
}

class _ScheduleTeacherKbmPageState extends State<ScheduleTeacherKbmPage> {
  late TeacherKbmBloc teacherKbmBloc;

  late LoginModel user;

  List<Map<String, dynamic>> days = [
    {
      'name': 'Senin',
      'key': 'monday',
      'isActive': true,
    },
    {
      'name': 'Selasa',
      'key': 'tuesday',
      'isActive': false,
    },
    {
      'name': 'Rabu',
      'key': 'wednesday',
      'isActive': false,
    },
    {
      'name': 'Kamis',
      'key': 'thursday',
      'isActive': false,
    },
    {
      'name': 'Jumat',
      'key': 'friday',
      'isActive': false,
    },
    {
      'name': 'Sabtu',
      'key': 'saturday',
      'isActive': false,
    },
  ];

  Map<String, dynamic> getActiveDay() {
    return days.firstWhere((element) => element['isActive'] == true);
  }

  Future<void> init() async {
    user = (await SessionAuth.getAuth())!;

    teacherKbmBloc = BlocProvider.of<TeacherKbmBloc>(context);
    teacherKbmBloc.add(OnGetTeacherKbm(getActiveDay()['key']));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

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
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: ColorAsset.GREEN,
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: days.map(
                          (val) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: ElevatedButton(
                                onPressed: () {
                                  for (var item in days) {
                                    item['isActive'] = false;
                                  }

                                  setState(() {
                                    val['isActive'] = true;
                                  });

                                  teacherKbmBloc.add(
                                      OnGetTeacherKbm(getActiveDay()['key']));
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: val['isActive']
                                      ? Colors.white
                                      : ColorAsset.GREEN_DARK,
                                  fixedSize: const Size(80, 80),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  val['name'],
                                  style: TextStyle(
                                    color: val['isActive']
                                        ? ColorAsset.GREEN
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      margin: const EdgeInsets.only(top: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                      ),
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: const Text(
                              'Jadwal Hari Ini',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Expanded(
                            child: BlocBuilder<TeacherKbmBloc, TeacherKbmState>(
                              builder: (context, state) {
                                if (state is TeacherKbmSuccess) {
                                  return ListView.builder(
                                    itemCount:
                                        state.teacherKbmModel.data.length,
                                    itemBuilder: (context, index) {
                                      final item =
                                          state.teacherKbmModel.data[index];

                                      return Column(
                                        children: [
                                          SizedBox(height: 16),
                                          Text(
                                            'Kelas ${item.classes.name}',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Card(
                                            color: Colors.white,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              side: const BorderSide(
                                                color: ColorAsset.GREEN,
                                                width: 4,
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 16,
                                                    horizontal: 24,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        color: ColorAsset.GREEN,
                                                        width: 4,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 50,
                                                        child: Text(
                                                          'No.',
                                                          style: TextStyle(
                                                            color: ColorAsset
                                                                .GREEN,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          'Mata Pelajaran',
                                                          style: TextStyle(
                                                            color: ColorAsset
                                                                .GREEN,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 50,
                                                        child: Text(
                                                          'Jam',
                                                          style: TextStyle(
                                                            color: ColorAsset
                                                                .GREEN,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: item.data.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final start_time =
                                                        DateFormat('HH:mm')
                                                            .format(DateFormat(
                                                                    'H:m:s')
                                                                .parse(item
                                                                    .data[index]
                                                                    .startTime));
                                                    final end_time = DateFormat(
                                                            'HH:mm')
                                                        .format(
                                                            DateFormat('H:m:s')
                                                                .parse(item
                                                                    .data[index]
                                                                    .endTime));

                                                    return Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 10,
                                                        horizontal: 24,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 50,
                                                            child: Text(
                                                              '${index + 1}.',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              item.data[index]
                                                                  .course.name,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ),
                                                          Column(
                                                            children: [
                                                              Container(
                                                                width: 50,
                                                                child: Text(
                                                                  start_time,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 50,
                                                                child: Text(
                                                                  end_time,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else if (state is TeacherKbmError) {
                                  return Center(
                                    child: Text(state.error),
                                  );
                                }
                                return const Center(
                                  child: SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      color: ColorAsset.GREEN,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
