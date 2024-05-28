import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:testing/blocs/schedule/exam/exam_bloc.dart';
import 'package:testing/blocs/schedule/exam/exam_event.dart';
import 'package:testing/blocs/schedule/exam/exam_state.dart';
import 'package:testing/utils/ColorAsset.dart';
import 'package:testing/utils/session_auth.dart';

class ScheduleExamPage extends StatefulWidget {
  const ScheduleExamPage({super.key});

  @override
  State<ScheduleExamPage> createState() => _ScheduleExamPageState();
}

class _ScheduleExamPageState extends State<ScheduleExamPage> {
  late ExamBloc examBloc;

  Color bgRandom(index) {
    if (index % 4 == 0) {
      return ColorAsset.GREEN_LIGHT_3;
    } else if (index % 3 == 0) {
      return ColorAsset.GREEN_LIGHT_2;
    } else if (index % 2 == 0) {
      return ColorAsset.GREEN_LIGHT_1;
    } else {
      return ColorAsset.GREEN;
    }
  }

  Future<void> init() async {
    final user = await SessionAuth.getAuth();

    examBloc = BlocProvider.of<ExamBloc>(context);

    if (user?.user.role == 'parent') {
      examBloc.add(OnGetExam(user?.user.id.toString()));
    } else {
      examBloc.add(OnGetExam(null));
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
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.only(top: 4),
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
                'Jadwal Ujian',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<ExamBloc, ExamState>(
                builder: (context, state) {
                  if (state is ExamSuccess) {
                    return ListView.builder(
                      itemCount: state.examModel.data.length,
                      itemBuilder: (context, index) {
                        final item = state.examModel.data[index];

                        final date_dd_MMM = DateFormat('dd MMM').format(
                          DateTime.parse(item.date.toString()),
                        );
                        final date_yyyy = DateFormat('yyyy').format(
                          DateTime.parse(item.date.toString()),
                        );
                        final date_dd_MMMM_yyyy =
                            DateFormat('dd MMMM yyyy').format(
                          DateTime.parse(item.date.toString()),
                        );

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    date_dd_MMM,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    date_yyyy,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: bgRandom(index),
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: item.schedule.map(
                                        (val) {
                                          return Text(
                                            val.course.name,
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                    // const Text(
                                    //   'Bahasa Indonesia',
                                    //   style: TextStyle(
                                    //     fontSize: 22,
                                    //     fontWeight: FontWeight.w700,
                                    //     color: Colors.white,
                                    //   ),
                                    // ),
                                    // const Text(
                                    //   'Fisika',
                                    //   style: TextStyle(
                                    //     fontSize: 22,
                                    //     fontWeight: FontWeight.w700,
                                    //     color: Colors.white,
                                    //   ),
                                    // ),
                                    SizedBox(height: 12),
                                    Text(
                                      '${date_dd_MMMM_yyyy} | ${item.startTime} - ${item.endTime}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
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
                  } else if (state is ExamError) {
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
    );
  }
}
