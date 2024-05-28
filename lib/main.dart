import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:testing/blocs/achievement/student_achievement_bloc.dart';
import 'package:testing/blocs/archive-file/archive_file_bloc.dart';
import 'package:testing/blocs/article/article_bloc.dart';
import 'package:testing/blocs/attendance-history/attendance_history_bloc.dart';
import 'package:testing/blocs/auth/login/login_bloc.dart';
import 'package:testing/blocs/auth/profile/profile_bloc.dart';
import 'package:testing/blocs/auth/register/register_bloc.dart';
import 'package:testing/blocs/indonesia-area/district/district_bloc.dart';
import 'package:testing/blocs/indonesia-area/province/province_bloc.dart';
import 'package:testing/blocs/indonesia-area/regency/regency_bloc.dart';
import 'package:testing/blocs/indonesia-area/village/village_bloc.dart';
import 'package:testing/blocs/master/all-student-classes/all_student_classes_bloc.dart';
import 'package:testing/blocs/master/all-student/all_student_bloc.dart';
import 'package:testing/blocs/master/classes/classes_bloc.dart';
import 'package:testing/blocs/master/semester/semester_bloc.dart';
import 'package:testing/blocs/master/study-year/study_year_bloc.dart';
import 'package:testing/blocs/master/teacher-classes/teacher_classes_bloc.dart';
import 'package:testing/blocs/notification/notification_bloc.dart';
import 'package:testing/blocs/schedule/academic_announcement/academic_announcement_bloc.dart';
import 'package:testing/blocs/schedule/exam/exam_bloc.dart';
import 'package:testing/blocs/schedule/kbm/kbm_bloc.dart';
import 'package:testing/blocs/schedule/krs/krs_bloc.dart';
import 'package:testing/blocs/schedule/teacher-kbm/kbm_bloc.dart';
import 'package:testing/blocs/student-report/student_report_bloc.dart';
import 'package:testing/blocs/sudy-result/kbm-result-save/kbm_result_save_bloc.dart';
import 'package:testing/blocs/sudy-result/kbm-result/kbm_result_bloc.dart';
import 'package:testing/blocs/sudy-result/khs/khs_bloc.dart';
import 'package:testing/blocs/sudy-result/transcript/transcript_bloc.dart';
import 'package:testing/presentations/splash_screen.dart';
import 'package:testing/routers/route_data.dart';
import 'package:testing/routers/route_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.camera.request();
  await Permission.microphone.request();
  await Permission.storage.request();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  // Plugin must be initialized before using
  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider<AcademicAnnouncementBloc>(
          create: (context) => AcademicAnnouncementBloc(),
        ),
        BlocProvider<KbmBloc>(
          create: (context) => KbmBloc(),
        ),
        BlocProvider<ExamBloc>(
          create: (context) => ExamBloc(),
        ),
        BlocProvider<KrsBloc>(
          create: (context) => KrsBloc(),
        ),
        BlocProvider<TeacherKbmBloc>(
          create: (context) => TeacherKbmBloc(),
        ),
        BlocProvider<StudentAchievementBloc>(
          create: (context) => StudentAchievementBloc(),
        ),
        BlocProvider<TranscriptBloc>(
          create: (context) => TranscriptBloc(),
        ),
        BlocProvider<ClassesBloc>(
          create: (context) => ClassesBloc(),
        ),
        BlocProvider<SemesterBloc>(
          create: (context) => SemesterBloc(),
        ),
        BlocProvider<TeacherClassesBloc>(
          create: (context) => TeacherClassesBloc(),
        ),
        BlocProvider<AllStudentClassesBloc>(
          create: (context) => AllStudentClassesBloc(),
        ),
        BlocProvider<KbmResultBloc>(
          create: (context) => KbmResultBloc(),
        ),
        BlocProvider<KbmResultSaveBloc>(
          create: (context) => KbmResultSaveBloc(),
        ),
        BlocProvider<StudyYearBloc>(
          create: (context) => StudyYearBloc(),
        ),
        BlocProvider<KhsBloc>(
          create: (context) => KhsBloc(),
        ),
        BlocProvider<ArchiveFileBloc>(
          create: (context) => ArchiveFileBloc(),
        ),
        BlocProvider<NotificationBloc>(
          create: (context) => NotificationBloc(),
        ),
        BlocProvider<ArticleBloc>(
          create: (context) => ArticleBloc(),
        ),
        BlocProvider<AllStudentBloc>(
          create: (context) => AllStudentBloc(),
        ),
        BlocProvider<ProvinceBloc>(
          create: (context) => ProvinceBloc(),
        ),
        BlocProvider<RegencyBloc>(
          create: (context) => RegencyBloc(),
        ),
        BlocProvider<DistrictBloc>(
          create: (context) => DistrictBloc(),
        ),
        BlocProvider<VillageBloc>(
          create: (context) => VillageBloc(),
        ),
        BlocProvider<AttendanceHistoryBloc>(
          create: (context) => AttendanceHistoryBloc(),
        ),
        BlocProvider<StudentReportBloc>(
          create: (context) => StudentReportBloc(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // fontFamily: 'Poppins',
        ),
        getPages: RouteData.data,
        initialRoute: RouteName.SPLASH_SCREEN,
        home: const SplashScreenPage(),
      ),
    );
  }
}
