import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing/presentations/auth/teacher_login.dart';
import 'package:testing/routers/route_name.dart';
import 'package:testing/utils/ColorAsset.dart';
import 'package:testing/utils/session_auth.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () async {
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(
        //       builder: (context) => const TeacherLoginPage(),
        //     ),
        //     (route) => false);
        if (await SessionAuth.isAuth()) {
          print('token: ${await SessionAuth.getToken()}');
          final role = (await SessionAuth.getAuth())?.user.role;

          if (role == 'student') {
            Get.offNamed(RouteName.MAIN_STUDENT);
          } else if (role == 'parent') {
            Get.offNamed(RouteName.MAIN_PARENT);
          } else if (role == 'teacher') {
            Get.offNamed(RouteName.MAIN_TEACHER);
          }
          return;
        }
        Get.offNamed(RouteName.STUDENT_LOGIN);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/decorations/bg.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        // color: ColorAsset.GREEN,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Text(
            //   "SPLASH SCREEN",
            //   style: TextStyle(
            //     fontSize: 16,
            //     color: Colors.white,
            //   ),
            // ),
            Container(
              width: MediaQuery.of(context).size.width - 150,
              height: MediaQuery.of(context).size.width - 150,
              child: Image.asset(
                'assets/decorations/logo.png',
              ),
            )
          ],
        ),
      ),
    );
  }
}
