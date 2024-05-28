import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testing/blocs/student-report/student_report_bloc.dart';
import 'package:testing/blocs/student-report/student_report_event.dart';
import 'package:testing/blocs/student-report/student_report_state.dart';
import 'package:testing/domain/models/login_model.dart';
import 'package:testing/utils/ColorAsset.dart';
import 'package:testing/utils/session_auth.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late StudentReportBloc studentReportBloc;

  late LoginModel user;

  ReceivePort _port = ReceivePort();

  Future<void> init() async {
    user = (await SessionAuth.getAuth())!;

    studentReportBloc = BlocProvider.of<StudentReportBloc>(context);
    studentReportBloc.add(OnGetStudentReport(
        user.user.role == 'parent' ? user.user.id.toString() : null));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = DownloadTaskStatus(data[1]);
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);

    init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Rapor'),
          centerTitle: true,
          backgroundColor: ColorAsset.GREEN,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<StudentReportBloc, StudentReportState>(
            builder: (context, state) {
              if (state is StudentReportSuccess) {
                return ListView.builder(
                  itemCount: state.studentReportModel.data.length,
                  itemBuilder: (context, index) {
                    final item = state.studentReportModel.data[index];

                    return GestureDetector(
                      onTap: () async {
                        final dir = await getExternalStorageDirectory();
                        print('DIR: ${dir?.path}');
                        try {
                          final taskId = await FlutterDownloader.enqueue(
                            url: item.urlDownloadConvert.toString(),
                            headers: {}, // optional: header send with url (auth token etc)
                            savedDir: dir!.path,
                            showNotification:
                                true, // show download progress in status bar (for Android)
                            openFileFromNotification:
                                true, // click on notification to open downloaded file (for Android)
                            saveInPublicStorage: true,
                          );
                          print('DOWNLOAD: $taskId');
                        } catch (e) {
                          print('DOWNLOAD: ${e.toString()}');
                        }
                      },
                      child: Stack(
                        children: [
                          Padding(
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
                                            'Tahun Ajaran',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                              '${item.studyYear.startYear}/${item.studyYear.endYear}'),
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
                                            'Kelas',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(item.classes.name),
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
                                            'Semester',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(item.semester.name),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1000),
                                color: ColorAsset.GREEN,
                              ),
                              padding: const EdgeInsets.all(3),
                              child: Icon(
                                Icons.download,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              } else if (state is StudentReportError) {
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
        ));
  }
}
