import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:testing/blocs/schedule/academic_announcement/academic_announcement_bloc.dart';
import 'package:testing/blocs/schedule/academic_announcement/academic_announcement_event.dart';
import 'package:testing/blocs/schedule/academic_announcement/academic_announcement_state.dart';
import 'package:testing/utils/ColorAsset.dart';

class AcademicAnnouncementPage extends StatefulWidget {
  const AcademicAnnouncementPage({super.key});

  @override
  State<AcademicAnnouncementPage> createState() =>
      _AcademicAnnouncementPageState();
}

class _AcademicAnnouncementPageState extends State<AcademicAnnouncementPage> {
  late AcademicAnnouncementBloc academicAnnouncementBloc;

  Color bgRandom(index) {
    if (index % 4 == 0) {
      return ColorAsset.GREEN_LIGHT_3;
    } else if (index % 3 == 0) {
      return ColorAsset.GREEN_LIGHT_2;
    } else if (index % 2 == 0) {
      return ColorAsset.GREEN_LIGHT_1;
    } else {
      return ColorAsset.GREEN;
    }
  }

  // List<Map<String, dynamic>> datas = [
  //   {
  //     'date': '01 Jan',
  //     'year': '2024',
  //     'title': 'Pengumuman Pendaftaran',
  //     'desc': '01 Januari 2024 | 08.00',
  //   },
  //   {
  //     'date': '05 Jan',
  //     'year': '2024',
  //     'title': 'Pendaftaran Santri Baru',
  //     'desc': '05-10 Jan 24 | 08.00',
  //   },
  //   {
  //     'date': '10 Jan',
  //     'year': '2024',
  //     'title': 'Tahap Seleksi',
  //     'desc': '10-12 Januari 2024',
  //   },
  //   {
  //     'date': '12 Jan',
  //     'year': '2024',
  //     'title': 'Pengumuman Penerimaan Santri Baru',
  //     'desc': '10-12 Januari 2024',
  //   },
  //   {
  //     'date': '14 Jan',
  //     'year': '2024',
  //     'title': 'Daftar Ulang Santri Baru',
  //     'desc': '14 Januari 2024 | 08.00 - 15.00',
  //   },
  // ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    academicAnnouncementBloc =
        BlocProvider.of<AcademicAnnouncementBloc>(context);
    academicAnnouncementBloc.add(OnGetAcademicAnnouncement());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Pendaftaran'),
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: ColorAsset.GREEN,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: const Text(
                  'Alur Proses Pelaksanaan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<AcademicAnnouncementBloc,
                    AcademicAnnouncementState>(
                  builder: (context, state) {
                    if (state is AcademicAnnouncementSuccess) {
                      return ListView.builder(
                        itemCount: state.academicAnnouncementModel.data
                            .itemRegistrationSchedule.length,
                        itemBuilder: (context, index) {
                          final item = state.academicAnnouncementModel.data
                              .itemRegistrationSchedule;
                          final date_dd_MMM = DateFormat('dd MMM').format(
                              DateTime.parse(item[index].startDate.toString()));
                          final date_yyyy = DateFormat('yyyy').format(
                              DateTime.parse(item[index].startDate.toString()));

                          final start_date_dd = DateFormat('dd').format(
                              DateTime.parse(item[index].startDate.toString()));
                          final start_date_mmm = DateFormat('MMM').format(
                              DateTime.parse(item[index].startDate.toString()));
                          final start_date_yy = DateFormat('yy').format(
                              DateTime.parse(item[index].startDate.toString()));

                          final end_date_dd = DateFormat('dd').format(
                              DateTime.parse(item[index].endDate.toString()));
                          final end_date_mmm = DateFormat('MMM').format(
                              DateTime.parse(item[index].endDate.toString()));
                          final end_date_yy = DateFormat('yy').format(
                              DateTime.parse(item[index].endDate.toString()));

                          final start_time = DateFormat('HH:mm').format(
                              DateFormat('H:m:s')
                                  .parse(item[index].startTime.toString()));
                          final end_time = DateFormat('HH:mm').format(
                              DateFormat('H:m:s')
                                  .parse(item[index].endTime.toString()));

                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      date_dd_MMM,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      date_yyyy,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: bgRandom(index),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  margin: const EdgeInsets.only(
                                    bottom: 12,
                                    left: 16,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item[index].title,
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Text(
                                        '${start_date_dd} - ${end_date_dd} ${start_date_mmm} ${start_date_yy} | ${start_time} - ${end_time}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (state is AcademicAnnouncementError) {
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
    );
  }
}
