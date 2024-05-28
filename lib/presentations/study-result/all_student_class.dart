import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:testing/blocs/master/all-student-classes/all_student_classes_bloc.dart';
import 'package:testing/blocs/master/all-student-classes/all_student_classes_event.dart';
import 'package:testing/blocs/master/all-student-classes/all_student_classes_state.dart';
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
import 'package:testing/presentations/study-result/student_result_kbm.dart';
import 'package:testing/utils/ColorAsset.dart';
import 'package:testing/utils/session_auth.dart';

class AllStudentClassPage extends StatefulWidget {
  const AllStudentClassPage({super.key});

  @override
  State<AllStudentClassPage> createState() => _AllStudentClassPageState();
}

class _AllStudentClassPageState extends State<AllStudentClassPage> {
  late AllStudentClassesBloc allStudentClassesBloc;

  late LoginModel user;

  Future<void> init() async {
    user = (await SessionAuth.getAuth())!;

    allStudentClassesBloc = BlocProvider.of<AllStudentClassesBloc>(context);
    allStudentClassesBloc.add(
      OnGetAllStudentClasses(
        Get.arguments['classes'].toString(),
        Get.arguments['study_year'].toString(),
      ),
    );
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
        title: const Text('Santri'),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: BlocBuilder<AllStudentClassesBloc, AllStudentClassesState>(
                builder: (context, state) {
                  if (state is AllStudentClassesSuccess) {
                    return ListView.builder(
                      itemCount: state.allStudentClassesModel.data.length,
                      itemBuilder: (context, index) {
                        final item = state.allStudentClassesModel.data[index];

                        return Container(
                          margin: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            bottom: 16,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              studentResultKbmDialog(
                                context,
                                Get.arguments['semester'].toString(),
                                Get.arguments['classes'].toString(),
                                item.student.id.toString(),
                                Get.arguments['study_year'].toString(),
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
                            child: Text(item.student.name),
                          ),
                        );
                      },
                    );
                  } else if (state is AllStudentClassesError) {
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
    );
  }
}

void studentResultKbmDialog(
  BuildContext context,
  String semester,
  String classes,
  String student,
  String study_year,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: StudentResultKbm(
          semester: semester,
          classes: classes,
          student: student,
          study_year: study_year,
        ),
      );
    },
  );
}
