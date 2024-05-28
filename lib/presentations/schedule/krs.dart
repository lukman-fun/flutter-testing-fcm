import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:testing/blocs/auth/profile/profile_bloc.dart';
import 'package:testing/blocs/auth/profile/profile_event.dart';
import 'package:testing/blocs/auth/profile/profile_state.dart';
import 'package:testing/blocs/schedule/krs/krs_bloc.dart';
import 'package:testing/blocs/schedule/krs/krs_event.dart';
import 'package:testing/blocs/schedule/krs/krs_state.dart';
import 'package:testing/routers/route_name.dart';
import 'package:testing/utils/ColorAsset.dart';
import 'package:testing/utils/session_auth.dart';

class KrsPage extends StatefulWidget {
  const KrsPage({super.key});

  @override
  State<KrsPage> createState() => _KrsPageState();
}

class _KrsPageState extends State<KrsPage> {
  late KrsBloc krsBloc;
  late ProfileBloc profileBloc;

  Future<void> init() async {
    final user = await SessionAuth.getAuth();
    krsBloc = BlocProvider.of<KrsBloc>(context);
    profileBloc = BlocProvider.of<ProfileBloc>(context);

    if (user?.user.role == 'parent') {
      krsBloc.add(OnGetKrs(user!.user.id.toString()));
      profileBloc.add(OnGetProfile(user.user.id.toString()));
    } else {
      krsBloc.add(OnGetKrs(null));
      profileBloc.add(OnGetProfile(null));
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
        title: const Text('Kartu Rencana Studi'),
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
                        margin: const EdgeInsets.only(
                          top: 16,
                          bottom: 4,
                        ),
                        child: BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            if (state is ProfileSuccess) {
                              return Text(
                                state.profileModel.user.name,
                                style: TextStyle(
                                  fontSize: 26,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              );
                            } else if (state is ProfileError) {}
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 4,
                          bottom: 16,
                        ),
                        child: BlocBuilder<KrsBloc, KrsState>(
                          builder: (context, state) {
                            if (state is KrsSuccess) {
                              return Text(
                                'KELAS ${state.krsModel.classes.name} | SEMESTER ${state.krsModel.semester.name}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              );
                            } else if (state is KrsError) {}
                            return const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          },
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
                                ],
                              ),
                            ),
                            BlocBuilder<KrsBloc, KrsState>(
                              builder: (context, state) {
                                if (state is KrsSuccess) {
                                  int orderNumber = 0;
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.krsModel.data.length,
                                    itemBuilder: (context, index) {
                                      final item = state.krsModel.data[index];

                                      if (item.course.valueable.toString() ==
                                          '1') {
                                        orderNumber++;
                                      }

                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 24,
                                        ),
                                        child: Row(
                                          children: [
                                            item.course.valueable.toString() ==
                                                    '1'
                                                ? Container(
                                                    width: 50,
                                                    child: Text(
                                                      '$orderNumber.',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  )
                                                : Container(),
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
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                } else if (state is KrsError) {
                                  return Center(
                                    child: Text(state.error),
                                  );
                                }

                                return Container(
                                  width: 16,
                                  height: 16,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  child: CircularProgressIndicator(
                                    color: ColorAsset.GREEN,
                                  ),
                                );
                              },
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 24,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: ColorAsset.GREEN,
                                    width: 4,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        'Jumlah Mata Pelajaran',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                  BlocBuilder<KrsBloc, KrsState>(
                                    builder: (context, state) {
                                      if (state is KrsSuccess) {
                                        return SizedBox(
                                            width: 50,
                                            child: Text(
                                              state.krsModel.data
                                                  .where((element) =>
                                                      element.course.valueable
                                                          .toString() ==
                                                      '1')
                                                  .length
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              textAlign: TextAlign.end,
                                            ));
                                      } else if (state is KrsError) {
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
                          ],
                        ),
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
