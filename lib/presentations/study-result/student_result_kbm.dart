import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:testing/blocs/sudy-result/kbm-result-save/kbm_result_save_bloc.dart';
import 'package:testing/blocs/sudy-result/kbm-result-save/kbm_result_save_event.dart';
import 'package:testing/blocs/sudy-result/kbm-result-save/kbm_result_save_state.dart';
import 'package:testing/blocs/sudy-result/kbm-result/kbm_result_bloc.dart';
import 'package:testing/blocs/sudy-result/kbm-result/kbm_result_event.dart';
import 'package:testing/blocs/sudy-result/kbm-result/kbm_result_state.dart';
import 'package:testing/utils/ColorAsset.dart';

class StudentResultKbm extends StatefulWidget {
  final String semester;
  final String classes;
  final String student;
  final String study_year;

  const StudentResultKbm({
    super.key,
    required this.semester,
    required this.classes,
    required this.student,
    required this.study_year,
  });

  @override
  State<StudentResultKbm> createState() => _StudentResultKbmState();
}

class _StudentResultKbmState extends State<StudentResultKbm> {
  late KbmResultBloc kbmResultBloc;
  late KbmResultSaveBloc kbmResultSaveBloc;

  var studentValueData = [];

  bool isStudentValuePushed(data) {
    for (var item in studentValueData) {
      if (item['id'] == data.course.id.toString()) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    kbmResultBloc = BlocProvider.of<KbmResultBloc>(context);
    kbmResultBloc.add(
      OnGetKbmResult(
        widget.semester,
        widget.classes,
        widget.student,
        widget.study_year,
      ),
    );

    kbmResultSaveBloc = BlocProvider.of<KbmResultSaveBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<KbmResultBloc, KbmResultState>(
              builder: (context, state) {
                if (state is KbmResultSuccess) {
                  studentValueData = [];

                  return ListView.builder(
                    itemCount: state.studentResultKbmModel.data.length,
                    itemBuilder: (context, index) {
                      final item = state.studentResultKbmModel.data[index];

                      if (!isStudentValuePushed(item)) {
                        studentValueData.add({
                          'student_result_id':
                              item.studentResultId.toString() != 'null'
                                  ? item.studentResultId.toString()
                                  : '',
                          'id': item.course.id.toString(),
                          'value': item.studentResultValue.toString() != 'null'
                              ? item.studentResultValue.toString()
                              : '0',
                          // 'value': item.studentResultValue.toString(),
                        });
                      }

                      print(studentValueData);

                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(item.course.name),
                            ),
                            SizedBox(
                              width: 70,
                              child: TextFormField(
                                initialValue: studentValueData[index]['value'],
                                onChanged: (value) {
                                  studentValueData[index]['value'] =
                                      value == '' ? '0' : value;

                                  print(studentValueData);
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Nilai',
                                  enabledBorder: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is KbmResultError) {
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
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    HashMap<String, dynamic> body = HashMap();
                    body['class'] = widget.classes.toString();
                    body['semester'] = widget.semester.toString();
                    body['student'] = widget.student.toString();
                    body['study_year'] = widget.study_year.toString();

                    body['data'] = studentValueData;

                    print(json.encode(body).toString());

                    kbmResultSaveBloc.add(OnSaveKbmResultSave(body));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorAsset.GREEN,
                    elevation: 0,
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      45,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: BlocBuilder<KbmResultSaveBloc, KbmResultSaveState>(
                    builder: (context, state) {
                      if (state is KbmResultSaveLoading) {
                        return const Text('Update...');
                      } else if (state is KbmResultSaveSuccess) {
                        Future.delayed(
                          Duration.zero,
                          () {
                            Get.back();
                            kbmResultSaveBloc.emit(KbmResultSaveInitial());
                          },
                        );
                      }

                      return const Text('Update');
                    },
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Batal'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    elevation: 0,
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      45,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
