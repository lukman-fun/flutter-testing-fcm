import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:testing/blocs/archive-file/archive_file_bloc.dart';
import 'package:testing/blocs/archive-file/archive_file_event.dart';
import 'package:testing/blocs/archive-file/archive_file_state.dart';
import 'package:testing/blocs/article/article_bloc.dart';
import 'package:testing/blocs/article/article_event.dart';
import 'package:testing/blocs/article/article_state.dart';
import 'package:testing/blocs/auth/profile/profile_bloc.dart';
import 'package:testing/blocs/auth/profile/profile_event.dart';
import 'package:testing/blocs/auth/profile/profile_state.dart';
import 'package:testing/blocs/schedule/academic_announcement/academic_announcement_bloc.dart';
import 'package:testing/blocs/schedule/academic_announcement/academic_announcement_event.dart';
import 'package:testing/blocs/schedule/academic_announcement/academic_announcement_state.dart';
import 'package:testing/blocs/schedule/krs/krs_bloc.dart';
import 'package:testing/blocs/schedule/krs/krs_event.dart';
import 'package:testing/blocs/schedule/krs/krs_state.dart';
import 'package:testing/domain/server/server_app.dart';
import 'package:testing/presentations/list-file-download/list_file_download.dart';
import 'package:testing/presentations/kpu/kpu.dart';
import 'package:testing/presentations/schedule/schedule.dart';
import 'package:testing/presentations/schedule/schedule_teacher_kbm.dart';
import 'package:testing/presentations/study-result/khs.dart';
import 'package:testing/presentations/schedule/krs.dart';
import 'package:testing/presentations/achievement/progress_note.dart';
import 'package:testing/presentations/study-result/teacher_class.dart';
import 'package:testing/presentations/study-result/transcript.dart';
import 'package:testing/routers/route_name.dart';
import 'package:testing/utils/ColorAsset.dart';
import 'package:testing/utils/session_auth.dart';

class HomeTeacherPage extends StatefulWidget {
  const HomeTeacherPage({super.key});

  @override
  State<HomeTeacherPage> createState() => _HomeTeacherPageState();
}

class _HomeTeacherPageState extends State<HomeTeacherPage> {
  late ProfileBloc profileBloc;
  late AcademicAnnouncementBloc academicAnnouncementBloc;
  late ArchiveFileBloc archiveFileBloc;
  late KrsBloc krsBloc;
  late ArticleBloc articleBloc;

  List<Map<String, dynamic>> data = [
    {
      'title': 'Jadwal',
      'sub_title': '',
      'icon': Icons.calendar_month_outlined,
      'to': const ScheduleTeacherKbmPage(),
      'to_name': RouteName.TEACHER_KBM,
    },
    {
      'title': 'Nilai',
      'sub_title': '',
      'icon': Icons.format_list_numbered_rounded,
      'to': const TeacherClassPage(),
      'to_name': RouteName.TEACHER_CLASS,
    },
    {
      'title': '',
      'sub_title': 'File yang dapat diunduh',
      'icon': Icons.note_sharp,
      'to': '',
      'to_name': 'file',
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(OnGetProfile(null));

    // academicAnnouncementBloc =
    //     BlocProvider.of<AcademicAnnouncementBloc>(context);
    // academicAnnouncementBloc.add(OnGetAcademicAnnouncement());

    archiveFileBloc = BlocProvider.of<ArchiveFileBloc>(context);
    archiveFileBloc.add(OnGetArchiveFile());

    // krsBloc = BlocProvider.of<KrsBloc>(context);
    // krsBloc.add(OnGetKrs(null));

    articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc.add(OnGetArticle());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text(
          'Assalamualaikum,',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const NotificationPage(),
              //   ),
              // );
              Get.toNamed(RouteName.NOTIFICATION);
            },
            icon: const Icon(Icons.notifications_none_rounded),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {
              SessionAuth.logout();
              Get.offAllNamed(RouteName.STUDENT_LOGIN);
            },
            icon: const Icon(Icons.logout),
            color: Colors.black,
          ),
        ],
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    // padding: const EdgeInsets.only(bottom: 70),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(224, 224, 224, 1),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BlocBuilder<ProfileBloc, ProfileState>(
                                  builder: (context, state) {
                                    if (state is ProfileSuccess) {
                                      return Text(
                                        state.profileModel.user.name,
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            overflow: TextOverflow.ellipsis),
                                        maxLines: 2,
                                      );
                                    } else if (state is ProfileError) {}
                                    return Container(
                                      width: 16,
                                      height: 16,
                                      margin: const EdgeInsets.only(
                                        bottom: 8,
                                      ),
                                      child: CircularProgressIndicator(
                                        color: ColorAsset.GREEN,
                                      ),
                                    );
                                  },
                                ),
                                Text(
                                  '2022.01',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 116, 116, 116),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const ProfilePage(),
                              //   ),
                              // );
                              Get.toNamed(RouteName.PROFILE);
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 40,
                              child: BlocBuilder<ProfileBloc, ProfileState>(
                                builder: (context, state) {
                                  if (state is ProfileSuccess) {
                                    if (state.profileModel.user.image != null &&
                                        !ServerApp.DEBUG) {
                                      return CircleAvatar(
                                        radius: 37,
                                        backgroundImage: NetworkImage(
                                            '${ServerApp.IMAGE_USER}${state.profileModel.user.image}'),
                                        // backgroundImage: NetworkImage(
                                        //     'https://picsum.photos/id/237/200/300'),
                                      );
                                    }

                                    return Container();
                                  }
                                  // return const CircleAvatar(
                                  //   radius: 37,
                                  //   backgroundImage: AssetImage(
                                  //       'assets/decorations/profile.png'),
                                  //   // backgroundImage: NetworkImage(
                                  //   //     'https://picsum.photos/id/237/200/300'),
                                  // );
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Positioned(
                  //   bottom: 0,
                  //   left: 0,
                  //   right: 0,
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(horizontal: 16),
                  //     child: SingleChildScrollView(
                  //       scrollDirection: Axis.horizontal,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: [
                  //           GestureDetector(
                  //             onTap: () {
                  //               // Navigator.of(context).push(
                  //               //   MaterialPageRoute(
                  //               //     builder: (context) =>
                  //               //         const AcademicAnnouncementPage(),
                  //               //   ),
                  //               // );
                  //               Get.toNamed(RouteName.ANNOUNCEMENT_ACADEMIC);
                  //             },
                  //             child: Card(
                  //               color: ColorAsset.ORANGE,
                  //               shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(
                  //                   20,
                  //                 ),
                  //               ),
                  //               child: Container(
                  //                 padding: const EdgeInsets.only(
                  //                   left: 16,
                  //                   top: 16,
                  //                   right: 10,
                  //                   bottom: 16,
                  //                 ),
                  //                 width: 200,
                  //                 child: Row(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Expanded(
                  //                       child: Column(
                  //                         crossAxisAlignment:
                  //                             CrossAxisAlignment.start,
                  //                         children: [
                  //                           BlocBuilder<
                  //                               AcademicAnnouncementBloc,
                  //                               AcademicAnnouncementState>(
                  //                             builder: (context, state) {
                  //                               if (state
                  //                                   is AcademicAnnouncementSuccess) {
                  //                                 return Text(
                  //                                   state
                  //                                       .academicAnnouncementModel
                  //                                       .data
                  //                                       .itemRegistrationSchedule
                  //                                       .length
                  //                                       .toString(),
                  //                                   style: TextStyle(
                  //                                     fontSize: 50,
                  //                                     fontWeight:
                  //                                         FontWeight.w900,
                  //                                     color: Colors.white,
                  //                                   ),
                  //                                 );
                  //                               }
                  //                               return const Text(
                  //                                 '0',
                  //                                 style: TextStyle(
                  //                                   fontSize: 50,
                  //                                   fontWeight: FontWeight.w900,
                  //                                   color: Colors.white,
                  //                                 ),
                  //                               );
                  //                             },
                  //                           ),
                  //                           const Text(
                  //                             'Pengumuman akademik',
                  //                             maxLines: 2,
                  //                             overflow: TextOverflow.ellipsis,
                  //                             style: TextStyle(
                  //                               fontSize: 16,
                  //                               color: Colors.white,
                  //                               fontWeight: FontWeight.bold,
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                     Icon(
                  //                       Icons.arrow_forward_ios_rounded,
                  //                       size: 30,
                  //                       color: Colors.white,
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //           SizedBox(width: 8),
                  //           GestureDetector(
                  //             onTap: () {
                  //               listFileDownload(context);
                  //             },
                  //             child: Card(
                  //               color: ColorAsset.GREEN_LIGHT,
                  //               shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(
                  //                   20,
                  //                 ),
                  //               ),
                  //               child: Container(
                  //                 padding: const EdgeInsets.only(
                  //                   left: 16,
                  //                   top: 16,
                  //                   right: 10,
                  //                   bottom: 16,
                  //                 ),
                  //                 width: 200,
                  //                 child: Row(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Expanded(
                  //                       child: Column(
                  //                         crossAxisAlignment:
                  //                             CrossAxisAlignment.start,
                  //                         children: [
                  //                           BlocBuilder<ArchiveFileBloc,
                  //                               ArchiveFileState>(
                  //                             builder: (context, state) {
                  //                               if (state
                  //                                   is ArchiveFileSuccess) {
                  //                                 return Text(
                  //                                   state.archiveFileModel.data
                  //                                       .length
                  //                                       .toString(),
                  //                                   style: TextStyle(
                  //                                     fontSize: 50,
                  //                                     fontWeight:
                  //                                         FontWeight.w900,
                  //                                     color: Colors.white,
                  //                                   ),
                  //                                 );
                  //                               }
                  //                               return const Text(
                  //                                 '0',
                  //                                 style: TextStyle(
                  //                                   fontSize: 50,
                  //                                   fontWeight: FontWeight.w900,
                  //                                   color: Colors.white,
                  //                                 ),
                  //                               );
                  //                             },
                  //                           ),
                  //                           const Text(
                  //                             'File yang dapat diunduh',
                  //                             maxLines: 2,
                  //                             overflow: TextOverflow.ellipsis,
                  //                             style: TextStyle(
                  //                               fontSize: 16,
                  //                               color: Colors.white,
                  //                               fontWeight: FontWeight.bold,
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                     Icon(
                  //                       Icons.arrow_forward_ios_rounded,
                  //                       size: 30,
                  //                       color: Colors.white,
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //           SizedBox(width: 8),
                  //           GestureDetector(
                  //             onTap: () {
                  //               // Navigator.push(
                  //               //   context,
                  //               //   MaterialPageRoute(
                  //               //     builder: (context) => const KrsPage(),
                  //               //   ),
                  //               // );
                  //               Get.toNamed(RouteName.KRS);
                  //             },
                  //             child: Card(
                  //               color: ColorAsset.GREEN,
                  //               shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(
                  //                   20,
                  //                 ),
                  //               ),
                  //               child: Container(
                  //                 padding: const EdgeInsets.only(
                  //                   left: 16,
                  //                   top: 16,
                  //                   right: 10,
                  //                   bottom: 16,
                  //                 ),
                  //                 width: 200,
                  //                 child: Row(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Expanded(
                  //                       child: Column(
                  //                         crossAxisAlignment:
                  //                             CrossAxisAlignment.start,
                  //                         children: [
                  //                           BlocBuilder<KrsBloc, KrsState>(
                  //                             builder: (context, state) {
                  //                               if (state is KrsSuccess) {
                  //                                 return Text(
                  //                                   state.krsModel.data.length
                  //                                       .toString(),
                  //                                   style: TextStyle(
                  //                                     fontSize: 50,
                  //                                     fontWeight:
                  //                                         FontWeight.w900,
                  //                                     color: Colors.white,
                  //                                   ),
                  //                                 );
                  //                               }
                  //                               return const Text(
                  //                                 '0',
                  //                                 style: TextStyle(
                  //                                   fontSize: 50,
                  //                                   fontWeight: FontWeight.w900,
                  //                                   color: Colors.white,
                  //                                 ),
                  //                               );
                  //                             },
                  //                           ),
                  //                           Text(
                  //                             'Jumlah mata pelajaran yang diambil',
                  //                             maxLines: 2,
                  //                             overflow: TextOverflow.ellipsis,
                  //                             style: TextStyle(
                  //                               fontSize: 16,
                  //                               color: Colors.white,
                  //                               fontWeight: FontWeight.bold,
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                     Icon(
                  //                       Icons.arrow_forward_ios_rounded,
                  //                       size: 30,
                  //                       color: Colors.white,
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //           SizedBox(width: 8),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        childAspectRatio: 13 / 14,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 3,
                      ),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => data[index]['to'],
                            //   ),
                            // );
                            if (data[index]['to_name'] == 'file') {
                              listFileDownload(context);
                            } else {
                              Get.toNamed(data[index]['to_name']);
                            }
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                            color: ColorAsset.GREEN,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    data[index]['icon'],
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 8),
                                        data[index]['title'] != ''
                                            ? Text(
                                                data[index]['title'],
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : Container(),
                                        data[index]['title'] != ''
                                            ? SizedBox(height: 3)
                                            : Container(),
                                        Text(
                                          data[index]['sub_title'],
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 16,
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 2,
                          bottom: 2,
                        ),
                        decoration: const BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            color: ColorAsset.GREEN,
                            style: BorderStyle.solid,
                            width: 3,
                          ),
                        )),
                        child: const Text(
                          'Artikel Terkini',
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorAsset.GREEN,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    BlocBuilder<ArticleBloc, ArticleState>(
                      builder: (context, state) {
                        if (state is ArticleSuccess) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.articleModel.data.length,
                            itemBuilder: (context, index) {
                              final item = state.articleModel.data[index];

                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                    RouteName.ARTICLE_DETAIL,
                                    arguments: {'data': item},
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 60,
                                        margin:
                                            const EdgeInsets.only(right: 16),
                                        clipBehavior: Clip.hardEdge,
                                        decoration: const BoxDecoration(
                                          color: ColorAsset.GREEN,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                        child: FadeInImage(
                                          image: NetworkImage(
                                            '${ServerApp.IMAGE_ARTICLE}${item.thumbnail}',
                                          ),
                                          placeholder: const AssetImage(
                                              'assets/decorations/logo.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.title,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              ServerApp.BASE_URL.substring(
                                                  0,
                                                  ServerApp.BASE_URL.length -
                                                      1),
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: ColorAsset.GREEN,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (state is ArticleError) {
                          return const Center(child: Text('Data Kosong'));
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void listFileDownload(BuildContext context) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      ),
    ),
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return const ListFileDownloadPage();
    },
  );
}
