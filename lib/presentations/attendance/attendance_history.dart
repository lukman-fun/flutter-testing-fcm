import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:testing/blocs/attendance-history/attendance_history_bloc.dart';
import 'package:testing/blocs/attendance-history/attendance_history_event.dart';
import 'package:testing/blocs/attendance-history/attendance_history_state.dart';
import 'package:testing/blocs/master/classes/classes_bloc.dart';
import 'package:testing/blocs/master/classes/classes_event.dart';
import 'package:testing/blocs/master/classes/classes_state.dart';
import 'package:testing/blocs/master/semester/semester_bloc.dart';
import 'package:testing/blocs/master/semester/semester_event.dart';
import 'package:testing/blocs/master/semester/semester_state.dart';
import 'package:testing/blocs/master/study-year/study_year_bloc.dart';
import 'package:testing/blocs/master/study-year/study_year_event.dart';
import 'package:testing/blocs/master/study-year/study_year_state.dart';
import 'package:testing/domain/models/login_model.dart';
import 'package:testing/utils/ColorAsset.dart';
import 'package:testing/utils/session_auth.dart';

class AttendanceHistoryPage extends StatefulWidget {
  const AttendanceHistoryPage({super.key});

  @override
  State<AttendanceHistoryPage> createState() => _AttendanceHistoryPageState();
}

class _AttendanceHistoryPageState extends State<AttendanceHistoryPage> {
  late StudyYearBloc studyYearBloc;
  late SemesterBloc semesterBloc;
  late ClassesBloc classesBloc;
  late AttendanceHistoryBloc attendanceHistoryBloc;

  String studyYearId = '0';
  String semesterId = '0';
  String classId = '0';

  late LoginModel user;

  Future<LoginModel> userInit() async {
    user = (await SessionAuth.getAuth())!;
    return user;
  }

  Future<void> init() async {
    await userInit();

    studyYearBloc = BlocProvider.of<StudyYearBloc>(context);
    studyYearBloc.add(OnGetStudyYear());

    semesterBloc = BlocProvider.of<SemesterBloc>(context);
    semesterBloc.add(OnGetSemester());

    classesBloc = BlocProvider.of<ClassesBloc>(context);

    attendanceHistoryBloc = BlocProvider.of<AttendanceHistoryBloc>(context);

    if (user.user.role == 'parent') {
      classesBloc.add(OnGetClasses(user.user.id.toString()));
      attendanceHistoryBloc.add(
          OnGetAttendanceHistory(null, null, null, user.user.id.toString()));
    } else {
      if (user.user.role != 'teacher') {
        classesBloc.add(OnGetClasses(null));
      }
      attendanceHistoryBloc.add(OnGetAttendanceHistory(null, null, null, null));
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histori Absensi'),
        centerTitle: true,
        backgroundColor: ColorAsset.GREEN,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: ColorAsset.GREEN,
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              padding: const EdgeInsets.only(
                bottom: 24,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        margin: const EdgeInsets.only(
                          right: 16,
                        ),
                        child: const Text(
                          'Tahun Ajaran',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(8),
                          ),
                          child: BlocBuilder<StudyYearBloc, StudyYearState>(
                            builder: (context, state) {
                              if (state is StudyYearSuccess) {
                                if (studyYearId == '0') {
                                  studyYearId = state
                                      .studyYearModel.currentStudyYear.id
                                      .toString();
                                }
                                return DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: studyYearId,
                                    isDense: true,
                                    isExpanded: true,
                                    items: state.studyYearModel.data.map((val) {
                                      return DropdownMenuItem(
                                        value: val.id.toString(),
                                        child: Text(
                                            '${val.startYear}/${val.endYear}'),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        studyYearId = newValue!.toString();
                                      });

                                      if (user.user.role == 'parent') {
                                        attendanceHistoryBloc.add(
                                            OnGetAttendanceHistory(
                                                studyYearId,
                                                semesterId,
                                                classId,
                                                user.user.id.toString()));
                                      } else {
                                        attendanceHistoryBloc.add(
                                            OnGetAttendanceHistory(studyYearId,
                                                semesterId, classId, null));
                                      }
                                    },
                                  ),
                                );
                              } else if (state is StudyYearError) {
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
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        margin: const EdgeInsets.only(
                          right: 16,
                        ),
                        child: const Text(
                          'Semester',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(8),
                          ),
                          child: BlocBuilder<SemesterBloc, SemesterState>(
                            builder: (context, state) {
                              if (state is SemesterSuccess) {
                                if (semesterId == '0') {
                                  semesterId = state
                                      .semesterModel.currentSemester.id
                                      .toString();
                                }
                                return DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: semesterId,
                                    isDense: true,
                                    isExpanded: true,
                                    items: state.semesterModel.data.map((val) {
                                      return DropdownMenuItem(
                                        value: val.id.toString(),
                                        child: Text(val.name),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        semesterId = newValue!.toString();
                                      });

                                      if (user.user.role == 'parent') {
                                        attendanceHistoryBloc.add(
                                            OnGetAttendanceHistory(
                                                studyYearId,
                                                semesterId,
                                                classId,
                                                user.user.id.toString()));
                                      } else {
                                        attendanceHistoryBloc.add(
                                            OnGetAttendanceHistory(studyYearId,
                                                semesterId, classId, null));
                                      }
                                    },
                                  ),
                                );
                              } else if (state is SemesterError) {
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
                      ),
                    ],
                  ),
                  FutureBuilder(
                    future: userInit(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data!.user.role != 'teacher') {
                        return Column(
                          children: [
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  margin: const EdgeInsets.only(
                                    right: 16,
                                  ),
                                  child: const Text(
                                    'Kelas',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InputDecorator(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                    child:
                                        BlocBuilder<ClassesBloc, ClassesState>(
                                      builder: (context, state) {
                                        if (state is ClassesSuccess) {
                                          if (classId == '0') {
                                            classId = state
                                                .classesModel.currentClass.id
                                                .toString();
                                          }
                                          return DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              value: classId,
                                              isDense: true,
                                              isExpanded: true,
                                              items: state.classesModel.data
                                                  .map((val) {
                                                return DropdownMenuItem(
                                                  value: val.id.toString(),
                                                  child: Text(val.name),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  classId = newValue.toString();
                                                });

                                                if (user.user.role ==
                                                    'parent') {
                                                  attendanceHistoryBloc.add(
                                                      OnGetAttendanceHistory(
                                                          studyYearId,
                                                          semesterId,
                                                          classId,
                                                          user.user.id
                                                              .toString()));
                                                } else {
                                                  attendanceHistoryBloc.add(
                                                      OnGetAttendanceHistory(
                                                          studyYearId,
                                                          semesterId,
                                                          classId,
                                                          null));
                                                }
                                              },
                                            ),
                                          );
                                        } else if (state is ClassesError) {
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
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                      return Container();
                    },
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: BlocBuilder<AttendanceHistoryBloc, AttendanceHistoryState>(
                builder: (context, state) {
                  if (state is AttendanceHistorySuccess) {
                    return ListView.builder(
                      // shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.attendanceHistoryModel.data.length,
                      itemBuilder: (context, index) {
                        final item = state.attendanceHistoryModel.data[index];
                        final date =
                            DateFormat('dd/MM/yyyy').format(item.createdAt);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Card(
                            color: Colors.white,
                            shadowColor: ColorAsset.GREEN,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Tanggal',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(date),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 0.8,
                                    height: 30,
                                    color: Colors.green,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Masuk',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(item.startAttend ?? '-'),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 0.8,
                                    height: 30,
                                    color: Colors.green,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Pulang',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(item.endAttend ?? '-'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is AttendanceHistoryError) {
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
          )
        ],
      ),
    );
  }
}
