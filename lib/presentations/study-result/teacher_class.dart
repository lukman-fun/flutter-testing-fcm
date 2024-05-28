import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:testing/blocs/master/classes/classes_bloc.dart';
import 'package:testing/blocs/master/classes/classes_state.dart';
import 'package:testing/blocs/master/semester/semester_bloc.dart';
import 'package:testing/blocs/master/semester/semester_event.dart';
import 'package:testing/blocs/master/semester/semester_state.dart';
import 'package:testing/blocs/master/study-year/study_year_bloc.dart';
import 'package:testing/blocs/master/study-year/study_year_event.dart';
import 'package:testing/blocs/master/study-year/study_year_state.dart';
import 'package:testing/blocs/master/teacher-classes/teacher_classes_bloc.dart';
import 'package:testing/blocs/master/teacher-classes/teacher_classes_event.dart';
import 'package:testing/blocs/master/teacher-classes/teacher_classes_state.dart';
import 'package:testing/domain/models/login_model.dart';
import 'package:testing/routers/route_name.dart';
import 'package:testing/utils/ColorAsset.dart';
import 'package:testing/utils/session_auth.dart';

class TeacherClassPage extends StatefulWidget {
  const TeacherClassPage({super.key});

  @override
  State<TeacherClassPage> createState() => _TeacherClassPageState();
}

class _TeacherClassPageState extends State<TeacherClassPage> {
  late StudyYearBloc studyYearBloc;
  late SemesterBloc semesterBloc;
  late TeacherClassesBloc teacherClassesBloc;

  String studyYearId = '0';
  String semesterId = '0';

  late LoginModel user;

  Future<void> init() async {
    user = (await SessionAuth.getAuth())!;

    studyYearBloc = BlocProvider.of<StudyYearBloc>(context);
    studyYearBloc.add(OnGetStudyYear());

    semesterBloc = BlocProvider.of<SemesterBloc>(context);
    semesterBloc.add(OnGetSemester());

    teacherClassesBloc = BlocProvider.of<TeacherClassesBloc>(context);
    teacherClassesBloc.add(OnGetTeacherClasses(null, null));
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
        title: const Text('Kelas'),
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
          Stack(
            children: [
              Container(
                height: 70,
                color: ColorAsset.GREEN,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            margin: const EdgeInsets.only(
                              right: 16,
                            ),
                            child: const Text(
                              'Periode',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
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
                                    child: BlocBuilder<StudyYearBloc,
                                        StudyYearState>(
                                      builder: (context, state) {
                                        if (state is StudyYearSuccess) {
                                          if (studyYearId == '0') {
                                            studyYearId = state.studyYearModel
                                                .currentStudyYear.id
                                                .toString();
                                          }
                                          return DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              value: studyYearId,
                                              isDense: true,
                                              isExpanded: true,
                                              items: state.studyYearModel.data
                                                  .map((val) {
                                                return DropdownMenuItem(
                                                  value: val.id.toString(),
                                                  child: Text(
                                                      '${val.startYear}/${val.endYear}'),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  studyYearId =
                                                      newValue!.toString();
                                                });

                                                teacherClassesBloc.add(
                                                  OnGetTeacherClasses(
                                                      semesterId.toString(),
                                                      studyYearId.toString()),
                                                );
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
                                SizedBox(width: 10),
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
                                    child: BlocBuilder<SemesterBloc,
                                        SemesterState>(
                                      builder: (context, state) {
                                        if (state is SemesterSuccess) {
                                          if (semesterId == '0') {
                                            semesterId = state.semesterModel
                                                .currentSemester.id
                                                .toString();
                                          }
                                          return DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              value: semesterId,
                                              isDense: true,
                                              isExpanded: true,
                                              items: state.semesterModel.data
                                                  .map((val) {
                                                return DropdownMenuItem(
                                                  value: val.id.toString(),
                                                  child: Text(val.name),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  semesterId =
                                                      newValue!.toString();
                                                });

                                                teacherClassesBloc.add(
                                                  OnGetTeacherClasses(
                                                      semesterId.toString(),
                                                      studyYearId.toString()),
                                                );
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<TeacherClassesBloc, TeacherClassesState>(
              builder: (context, state) {
                if (state is TeacherClassesSuccess) {
                  return ListView.builder(
                    itemCount: state.teacherClassesModel.data.length,
                    itemBuilder: (context, index) {
                      final item = state.teacherClassesModel.data[index];

                      return Container(
                        margin: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 16,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed(
                              RouteName.ALL_STUDENT_CLASS,
                              arguments: {
                                'classes': item.id.toString(),
                                'study_year': studyYearId.toString(),
                                'semester': semesterId.toString(),
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorAsset.GREEN,
                            fixedSize: Size(
                              MediaQuery.of(context).size.width,
                              55,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text('Kelas ${item.name}'),
                        ),
                      );
                    },
                  );
                } else if (state is TeacherClassesError) {
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
    );
  }
}
