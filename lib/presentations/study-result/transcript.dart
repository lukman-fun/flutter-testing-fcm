import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:testing/blocs/auth/profile/profile_bloc.dart';
import 'package:testing/blocs/auth/profile/profile_event.dart';
import 'package:testing/blocs/auth/profile/profile_state.dart';
import 'package:testing/blocs/sudy-result/transcript/transcript_bloc.dart';
import 'package:testing/blocs/sudy-result/transcript/transcript_event.dart';
import 'package:testing/blocs/sudy-result/transcript/transcript_state.dart';
import 'package:testing/routers/route_name.dart';
import 'package:testing/utils/ColorAsset.dart';
import 'package:testing/utils/session_auth.dart';

class TranscriptPage extends StatefulWidget {
  const TranscriptPage({super.key});

  @override
  State<TranscriptPage> createState() => _TranscriptPageState();
}

class _TranscriptPageState extends State<TranscriptPage> {
  late ProfileBloc profileBloc;
  late TranscriptBloc transcriptBloc;

  double averageValue = 0;

  Future<void> init() async {
    final user = await SessionAuth.getAuth();
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    transcriptBloc = BlocProvider.of<TranscriptBloc>(context);

    if (user?.user.role == 'parent') {
      profileBloc.add(OnGetProfile(user?.user.id.toString()));
      transcriptBloc.add(OnGetTranscript(user?.user.id.toString()));
    } else {
      profileBloc.add(OnGetProfile(null));
      transcriptBloc.add(OnGetTranscript(null));
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
        title: const Text('Transkrip'),
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
                  height: 100,
                  color: ColorAsset.GREEN,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          if (state is ProfileSuccess) {
                            return Card(
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
                                    padding: const EdgeInsets.only(
                                      top: 16,
                                      left: 24,
                                      right: 24,
                                      bottom: 8,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 80,
                                          child: Text(
                                            'Nama',
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
                                            ': ${state.profileModel.user.name}',
                                            overflow: TextOverflow.ellipsis,
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
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      left: 24,
                                      right: 24,
                                      bottom: 8,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 80,
                                          child: Text(
                                            'NIS',
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
                                            ': ${state.profileModel.user.studentBiodata?.nisn}',
                                            overflow: TextOverflow.ellipsis,
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
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      left: 24,
                                      right: 24,
                                      bottom: 8,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 80,
                                          child: Text(
                                            'No.Ujian',
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
                                            ': 123-456-78-90',
                                            overflow: TextOverflow.ellipsis,
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
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      left: 24,
                                      right: 24,
                                      bottom: 16,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 190,
                                          child: Text(
                                            'Rata-Rata Nilai Akhir',
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
                                            ': ${state.profileModel.transcriptValue.valueAverage.toString().replaceAll('.', ',')}',
                                            overflow: TextOverflow.ellipsis,
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
                                  ),
                                ],
                              ),
                            );
                          } else if (state is ProfileError) {
                            return Center(
                              child: Text(
                                state.error,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }
                          return Center(
                            child: Container(
                              width: 16,
                              height: 16,
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                      BlocBuilder<TranscriptBloc, TranscriptState>(
                        builder: (context, state) {
                          if (state is TranscriptSuccess) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.transcriptModel.data.length,
                              itemBuilder: (context, index) {
                                final item = state.transcriptModel.data[index];

                                return Column(
                                  children: [
                                    SizedBox(height: 16),
                                    Text(
                                      'Semester ${item.semester.name}',
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
                                                      fontWeight:
                                                          FontWeight.w700,
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
                                                      fontWeight:
                                                          FontWeight.w700,
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
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    textAlign: TextAlign.start,
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
                                            itemBuilder: (context, index) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        item.data[index].course
                                                            .name,
                                                        style: TextStyle(
                                                          color: Colors.black,
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
                                                        item.data[index]
                                                            .valueResult,
                                                        style: TextStyle(
                                                          color: Colors.black,
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
                          } else if (state is TranscriptError) {
                            return Center(
                              child: Text(state.error),
                            );
                          }
                          return Center(
                            child: Container(
                              width: 16,
                              height: 16,
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              child: CircularProgressIndicator(
                                color: ColorAsset.GREEN,
                              ),
                            ),
                          );
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 24,
                          bottom: 24,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const SchedulePage(),
                            //   ),
                            // );
                            Get.toNamed(RouteName.SCHEDULE);
                          },
                          child: const Text(
                            'Lihat Jadwal',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorAsset.GREEN,
                            elevation: 0,
                            fixedSize: Size(
                              MediaQuery.of(context).size.width,
                              60,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
