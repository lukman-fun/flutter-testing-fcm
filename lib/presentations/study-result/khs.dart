import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:testing/blocs/master/classes/classes_bloc.dart';
import 'package:testing/blocs/master/classes/classes_event.dart';
import 'package:testing/blocs/master/classes/classes_state.dart';
import 'package:testing/blocs/master/semester/semester_bloc.dart';
import 'package:testing/blocs/master/semester/semester_event.dart';
import 'package:testing/blocs/master/semester/semester_state.dart';
import 'package:testing/blocs/sudy-result/khs/khs_bloc.dart';
import 'package:testing/blocs/sudy-result/khs/khs_event.dart';
import 'package:testing/blocs/sudy-result/khs/khs_state.dart';
import 'package:testing/domain/models/login_model.dart';
import 'package:testing/utils/ColorAsset.dart';
import 'package:testing/utils/session_auth.dart';

class KhsPage extends StatefulWidget {
  const KhsPage({super.key});

  @override
  State<KhsPage> createState() => _KhsPageState();
}

class _KhsPageState extends State<KhsPage> {
  late ClassesBloc classesBloc;
  late SemesterBloc semesterBloc;
  late KhsBloc khsBloc;

  String classId = '0';
  String semesterId = '0';

  List<int> dest = [1, 2, 3];

  late LoginModel user;

  Future<void> init() async {
    user = (await SessionAuth.getAuth())!;

    classesBloc = BlocProvider.of<ClassesBloc>(context);

    semesterBloc = BlocProvider.of<SemesterBloc>(context);
    semesterBloc.add(OnGetSemester());

    khsBloc = BlocProvider.of<KhsBloc>(context);

    if (user.user.role == 'parent') {
      classesBloc.add(OnGetClasses(user.user.id.toString()));
      khsBloc.add(OnGetKhs(null, null, user.user.id.toString()));
    } else {
      classesBloc.add(OnGetClasses(null));
      khsBloc.add(OnGetKhs(null, null, null));
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
        title: const Text('Kartu Hasil Studi'),
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
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
                                      child: BlocBuilder<ClassesBloc,
                                          ClassesState>(
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
                                                    classId =
                                                        newValue.toString();
                                                  });

                                                  if (user.user.role ==
                                                      'parent') {
                                                    khsBloc.add(
                                                      OnGetKhs(
                                                        classId.toString(),
                                                        semesterId.toString(),
                                                        user.user.id.toString(),
                                                      ),
                                                    );
                                                  } else {
                                                    khsBloc.add(
                                                      OnGetKhs(
                                                        classId.toString(),
                                                        semesterId.toString(),
                                                        null,
                                                      ),
                                                    );
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

                                                  if (user.user.role ==
                                                      'parent') {
                                                    khsBloc.add(
                                                      OnGetKhs(
                                                        classId.toString(),
                                                        semesterId.toString(),
                                                        user.user.id.toString(),
                                                      ),
                                                    );
                                                  } else {
                                                    khsBloc.add(
                                                      OnGetKhs(
                                                          classId.toString(),
                                                          semesterId.toString(),
                                                          null),
                                                    );
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
                            ),
                          ],
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            color: ColorAsset.GREEN,
                            width: 4,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
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
                                        color: ColorAsset.GREEN,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Mata Pelajaran',
                                      style: TextStyle(
                                        color: ColorAsset.GREEN,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Container(
                                    width: 50,
                                    child: Text(
                                      'Nilai',
                                      style: TextStyle(
                                        color: ColorAsset.GREEN,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            BlocBuilder<KhsBloc, KhsState>(
                              builder: (context, state) {
                                if (state is KhsSuccess) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.khsModel.data.length,
                                    itemBuilder: (context, index) {
                                      final item = state.khsModel.data[index];

                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 24,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 50,
                                              child: Text(
                                                '${index + 1}.',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                item.course.name,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            Container(
                                              width: 50,
                                              margin: const EdgeInsets.only(
                                                  left: 16),
                                              child: Text(
                                                item.studentResultValue != null
                                                    ? item.studentResultValue
                                                        .toString()
                                                    : 'x',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                } else if (state is KhsError) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Text(state.error),
                                  );
                                }

                                return Container(
                                  width: 16,
                                  height: 16,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: CircularProgressIndicator(
                                    color: ColorAsset.GREEN,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: Card(
                          color: Colors.grey[300],
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: const BorderSide(
                              color: ColorAsset.GREEN,
                              width: 4,
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 24,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      'Jumlah Nilai',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                BlocBuilder<KhsBloc, KhsState>(
                                  builder: (context, state) {
                                    if (state is KhsSuccess) {
                                      return Container(
                                        width: 50,
                                        child: Text(
                                          state.khsModel.transcriptValue
                                              .totalAllCourseValue
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      );
                                    } else if (state is KhsError) {
                                      return const Center(
                                        child: Text('0'),
                                      );
                                    }
                                    return const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        color: ColorAsset.GREEN,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: Card(
                          color: Colors.grey[300],
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: const BorderSide(
                              color: ColorAsset.GREEN,
                              width: 4,
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 24,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      'Rata-Rata Nilai',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                BlocBuilder<KhsBloc, KhsState>(
                                  builder: (context, state) {
                                    if (state is KhsSuccess) {
                                      return Container(
                                        width: 50,
                                        child: Text(
                                          state.khsModel.transcriptValue
                                              .valueAverage
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      );
                                    } else if (state is KhsError) {
                                      return const Center(
                                        child: Text('0'),
                                      );
                                    }
                                    return const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        color: ColorAsset.GREEN,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
