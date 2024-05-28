import 'package:get/get.dart';
import 'package:testing/presentations/achievement/progress_note.dart';
import 'package:testing/presentations/auth/parent_login.dart';
import 'package:testing/presentations/auth/student_login.dart';
import 'package:testing/presentations/auth/teacher_login.dart';
import 'package:testing/presentations/forgot_password/forgot_password_change.dart';
import 'package:testing/presentations/forgot_password/forgot_password_email.dart';
import 'package:testing/presentations/forgot_password/forgot_password_otp.dart';
import 'package:testing/presentations/home/detail_article.dart';
import 'package:testing/presentations/kpu/kpu.dart';
import 'package:testing/presentations/main_parent.dart';
import 'package:testing/presentations/main_student.dart';
import 'package:testing/presentations/main_teacher.dart';
import 'package:testing/presentations/notification/notification.dart';
import 'package:testing/presentations/profile/profile.dart';
import 'package:testing/presentations/schedule/academic_announcement.dart';
import 'package:testing/presentations/schedule/schedule.dart';
import 'package:testing/presentations/schedule/schedule_teacher_kbm.dart';
import 'package:testing/presentations/splash_screen.dart';
import 'package:testing/presentations/study-result/all_student_class.dart';
import 'package:testing/presentations/study-result/khs.dart';
import 'package:testing/presentations/schedule/krs.dart';
import 'package:testing/presentations/study-result/teacher_class.dart';
import 'package:testing/presentations/study-result/transcript.dart';
import 'package:testing/routers/route_name.dart';

class RouteData {
  static var data = [
    GetPage(
      name: RouteName.SPLASH_SCREEN,
      page: () => const SplashScreenPage(),
    ),
    GetPage(
      name: RouteName.MAIN_STUDENT,
      page: () => const MainStudentPage(),
    ),
    GetPage(
      name: RouteName.MAIN_PARENT,
      page: () => const MainParentPage(),
    ),
    GetPage(
      name: RouteName.MAIN_TEACHER,
      page: () => const MainTeacherPage(),
    ),
    GetPage(
      name: RouteName.PARENT_LOGIN,
      page: () => const ParentLoginPage(),
    ),
    GetPage(
      name: RouteName.STUDENT_LOGIN,
      page: () => const StudentLoginPage(),
    ),
    GetPage(
      name: RouteName.TEACHER_LOGIN,
      page: () => const TeacherLoginPage(),
    ),
    GetPage(
      name: RouteName.KRS,
      page: () => const KrsPage(),
    ),
    GetPage(
      name: RouteName.SCHEDULE,
      page: () => const SchedulePage(),
    ),
    GetPage(
      name: RouteName.TEACHER_KBM,
      page: () => const ScheduleTeacherKbmPage(),
    ),
    GetPage(
      name: RouteName.TEACHER_CLASS,
      page: () => const TeacherClassPage(),
    ),
    GetPage(
      name: RouteName.ALL_STUDENT_CLASS,
      page: () => const AllStudentClassPage(),
    ),
    GetPage(
      name: RouteName.ACHIVEMENT,
      page: () => const ProgressNotePage(),
    ),
    GetPage(
      name: RouteName.KPU,
      page: () => const KpuPage(),
    ),
    GetPage(
      name: RouteName.TRANSCRIPT,
      page: () => const TranscriptPage(),
    ),
    GetPage(
      name: RouteName.KHS,
      page: () => const KhsPage(),
    ),
    GetPage(
      name: RouteName.ANNOUNCEMENT_ACADEMIC,
      page: () => const AcademicAnnouncementPage(),
    ),
    GetPage(
      name: RouteName.NOTIFICATION,
      page: () => const NotificationPage(),
    ),
    GetPage(
      name: RouteName.FORGOT_PASSWORD_CHANGE,
      page: () => const ForgotPasswordChangePage(),
    ),
    GetPage(
      name: RouteName.FORGOT_PASSWORD_EMAIL,
      page: () => const ForgotPasswordEmailPage(),
    ),
    GetPage(
      name: RouteName.FORGOT_PASSWORD_OTP,
      page: () => const ForgotPasswordOtpPage(),
    ),
    GetPage(
      name: RouteName.PROFILE,
      page: () => const ProfilePage(),
    ),
    GetPage(
      name: RouteName.ARTICLE_DETAIL,
      page: () => const ArticleDetail(),
    ),
  ];
}
