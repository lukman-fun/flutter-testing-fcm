import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:testing/blocs/schedule/kbm/kbm_bloc.dart';
import 'package:testing/blocs/schedule/kbm/kbm_event.dart';
import 'package:testing/blocs/schedule/kbm/kbm_state.dart';
import 'package:testing/domain/models/login_model.dart';
import 'package:testing/utils/ColorAsset.dart';
import 'package:testing/utils/session_auth.dart';

class ScheduleKbmPage extends StatefulWidget {
  const ScheduleKbmPage({super.key});

  @override
  State<ScheduleKbmPage> createState() => _ScheduleKbmPageState();
}

class _ScheduleKbmPageState extends State<ScheduleKbmPage> {
  late KbmBloc kbmBloc;

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
    {
      'name': 'Ahad',
      'key': 'sunday',
      'isActive': false,
    },
  ];

  Map<String, dynamic> getActiveDay() {
    return days.firstWhere((element) => element['isActive'] == true);
  }

  Future<void> init() async {
    user = (await SessionAuth.getAuth())!;

    kbmBloc = BlocProvider.of<KbmBloc>(context);

    if (user.user.role == 'parent') {
      kbmBloc.add(OnGetKbm(getActiveDay()['key'], user.user.id.toString()));
    } else {
      kbmBloc.add(OnGetKbm(getActiveDay()['key'], null));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ElevatedButton(
                        onPressed: () {
                          for (var item in days) {
                            item['isActive'] = false;
                          }

                          setState(() {
                            val['isActive'] = true;
                          });

                          if (user.user.role == 'parent') {
                            kbmBloc.add(OnGetKbm(getActiveDay()['key'],
                                user.user.id.toString()));
                          } else {
                            kbmBloc.add(OnGetKbm(getActiveDay()['key'], null));
                          }
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
                    child: BlocBuilder<KbmBloc, KbmState>(
                      builder: (context, state) {
                        if (state is KbmSuccess) {
                          return ListView.builder(
                            itemCount: state.kbmModel.data.length,
                            itemBuilder: (context, index) {
                              final item = state.kbmModel.data[index];

                              final start_time = DateFormat('HH:mm').format(
                                  DateFormat('H:m:s').parse(item.startTime));
                              final end_time = DateFormat('HH:mm').format(
                                  DateFormat('H:m:s').parse(item.endTime));

                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          start_time,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            height: 0.8,
                                          ),
                                        ),
                                        Text(
                                          '-',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            height: 0.8,
                                          ),
                                        ),
                                        Text(
                                          end_time,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            height: 0.8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      // height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      margin: const EdgeInsets.only(
                                        bottom: 12,
                                        left: 16,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 16,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.course.name,
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else if (state is KbmError) {
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
    );
  }
}
