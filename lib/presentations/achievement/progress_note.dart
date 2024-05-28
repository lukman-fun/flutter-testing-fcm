import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:testing/blocs/achievement/student_achievement_bloc.dart';
import 'package:testing/blocs/achievement/student_achievement_event.dart';
import 'package:testing/blocs/achievement/student_achievement_state.dart';
import 'package:testing/domain/models/login_model.dart';
import 'package:testing/utils/ColorAsset.dart';
import 'package:testing/utils/session_auth.dart';

class ProgressNotePage extends StatefulWidget {
  const ProgressNotePage({super.key});

  @override
  State<ProgressNotePage> createState() => _ProgressNotePageState();
}

class _ProgressNotePageState extends State<ProgressNotePage> {
  late StudentAchievementBloc studentAchievementBloc;

  String type = 'performance';

  List<int> dest = [
    1,
  ];

  late LoginModel user;

  Future<void> init() async {
    user = (await SessionAuth.getAuth())!;

    studentAchievementBloc = BlocProvider.of<StudentAchievementBloc>(context);

    if (user.user.role == 'parent') {
      studentAchievementBloc
          .add(OnGetStudentAchievement(type, user.user.id.toString()));
    } else {
      studentAchievementBloc.add(OnGetStudentAchievement(type, null));
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
        title: const Text('Catatan Perkembangan Santri'),
        titleSpacing: 0,
        backgroundColor: ColorAsset.GREEN,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
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
                                'Catatan',
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
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: 'performance',
                                    isDense: true,
                                    isExpanded: true,
                                    items: const [
                                      DropdownMenuItem(
                                        value: 'performance',
                                        child: Text('Prestasi Santri'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'fault',
                                        child: Text('Pelanggaran Santri'),
                                      ),
                                    ],
                                    onChanged: (newValue) {
                                      setState(() {
                                        type = newValue!;
                                      });

                                      if (user.user.role == 'parent') {
                                        studentAchievementBloc.add(
                                            OnGetStudentAchievement(
                                                type, user.user.id.toString()));
                                      } else {
                                        studentAchievementBloc.add(
                                            OnGetStudentAchievement(
                                                type, null));
                                      }
                                    },
                                  ),
                                ),
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
                        child: Container(
                          height: MediaQuery.of(context).size.height - 164,
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
                                        'Prestasi',
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
                                        'Tgl.',
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
                              Expanded(
                                child: BlocBuilder<StudentAchievementBloc,
                                    StudentAchievementState>(
                                  builder: (context, state) {
                                    if (state is StudentAchievementSuccess) {
                                      return ListView.builder(
                                        itemCount: state.studentAchievementModel
                                            .data.length,
                                        itemBuilder: (context, index) {
                                          final item = state
                                              .studentAchievementModel
                                              .data[index];

                                          final date =
                                              DateFormat('dd/MM').format(
                                            DateTime.parse(item.achievementDate
                                                .toString()),
                                          );

                                          return Container(
                                            padding: const EdgeInsets.symmetric(
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
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    item.title,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                Container(
                                                  width: 50,
                                                  child: Text(
                                                    date,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    } else if (state
                                        is StudentAchievementError) {
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
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
