import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:testing/blocs/auth/login/login_bloc.dart';
import 'package:testing/blocs/auth/login/login_event.dart';
import 'package:testing/domain/models/login_model.dart';
import 'package:testing/presentations/forgot_password/forgot_password_email.dart';
import 'package:testing/routers/route_name.dart';
import 'package:testing/utils/ColorAsset.dart';

import '../../blocs/auth/login/login_state.dart';

class StudentLoginPage extends StatefulWidget {
  const StudentLoginPage({super.key});

  @override
  State<StudentLoginPage> createState() => _StudentLoginPageState();
}

class _StudentLoginPageState extends State<StudentLoginPage> {
  late LoginBloc loginBloc;

  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool isPasswordVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    loginBloc.emit(LoginInitial());
    // loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 30,
                    right: 30,
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pushAndRemoveUntil(
                        //     MaterialPageRoute(
                        //       builder: (context) => const MainParentPage(),
                        //     ),
                        //     (route) => false);
                        // Get.offNamed(RouteName.MAIN);
                        HashMap<String, dynamic> body = HashMap();
                        body['username'] = _username.text;
                        body['password'] = _password.text;
                        body['role'] = 'student';

                        loginBloc.add(OnLogin(body));
                      },
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        elevation: 16,
                        // color: ColorAsset().toColor(ColorAsset.ORANGE),
                        color: ColorAsset.ORANGE,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                          width: MediaQuery.of(context).size.width - 200,
                          child: BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              if (state is LoginLoading) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    SizedBox(
                                      width: 14,
                                      height: 14,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 14),
                                    Text(
                                      'LOGIN',
                                      style: TextStyle(
                                        fontSize: 18,
                                        letterSpacing: 3,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              } else if (state is LoginSuccess) {
                                // Future.delayed(Duration.zero, () {
                                //   Get.snackbar(
                                //     'Success',
                                //     'Login Success',
                                //     colorText: Colors.white,
                                //     backgroundColor: Colors.green,
                                //     icon: const Icon(
                                //       Icons.check,
                                //       color: Colors.white,
                                //     ),
                                //     margin: const EdgeInsets.symmetric(
                                //       vertical: 16,
                                //       horizontal: 16,
                                //     ),
                                //   );
                                // Future.delayed(Duration.zero, () {
                                //   print('INI MAU KE MAIN');
                                //   Get.offNamed(RouteName.MAIN);
                                // });
                                Future.delayed(Duration.zero, () {
                                  Get.showSnackbar(
                                    const GetSnackBar(
                                      message: 'Login Successfully',
                                      icon: Icon(
                                        Icons.check_circle_outline_rounded,
                                        color: Colors.white,
                                      ),
                                      duration: Duration(seconds: 3),
                                      margin: EdgeInsets.all(8),
                                      backgroundColor: Colors.green,
                                      borderRadius: 8,
                                      snackPosition: SnackPosition.TOP,
                                    ),
                                  );

                                  Get.offNamed(RouteName.MAIN_STUDENT);
                                  loginBloc.emit(LoginInitial());
                                });
                                // });
                              } else if (state is LoginError) {
                                Future.delayed(Duration.zero, () {
                                  Get.showSnackbar(
                                    GetSnackBar(
                                      message: state.error,
                                      icon: const Icon(
                                        Icons.warning_amber_rounded,
                                        color: Colors.white,
                                      ),
                                      duration: const Duration(seconds: 3),
                                      margin: const EdgeInsets.all(8),
                                      backgroundColor: Colors.red,
                                      borderRadius: 8,
                                      snackPosition: SnackPosition.TOP,
                                    ),
                                  );

                                  loginBloc.emit(LoginInitial());
                                });
                              }
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'LOGIN',
                                    style: TextStyle(
                                      fontSize: 18,
                                      letterSpacing: 3,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 47),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 16,
                      color: ColorAsset.GREEN_ALPHA,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(
                          left: 24,
                          top: 55,
                          right: 24,
                          bottom: 24,
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "SANTRI",
                              style: TextStyle(
                                color: ColorAsset.GREEN,
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 3,
                              ),
                            ),
                            SizedBox(height: 24),
                            TextFormField(
                              controller: _username,
                              style: const TextStyle(
                                // Specify your text style properties here
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ColorAsset.GREEN,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Username',
                                hintStyle: const TextStyle(
                                  // Specify your text style properties here
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              controller: _password,
                              obscureText: !isPasswordVisible,
                              style: const TextStyle(
                                // Specify your text style properties here
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ColorAsset.GREEN,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Password',
                                hintStyle: const TextStyle(
                                  // Specify your text style properties here
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                  icon: isPasswordVisible
                                      ? Icon(
                                          Icons.visibility,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          Icons.visibility_off,
                                          color: Colors.white,
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      fillColor:
                                          MaterialStateProperty.resolveWith(
                                        (states) => ColorAsset.GREEN,
                                      ),
                                      value: true,
                                      onChanged: (value) {},
                                    ),
                                    const Text(
                                      'Ingat Saya',
                                      style: TextStyle(
                                        color: ColorAsset.GREEN,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPasswordEmailPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Lupa Password',
                                    style: TextStyle(
                                      color: ColorAsset.GREEN,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: ColorAsset.ORANGE,
                            borderRadius: BorderRadius.circular(1000),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                // Navigator.of(context).pushAndRemoveUntil(
                //     MaterialPageRoute(
                //       builder: (context) => const TeacherLoginPage(),
                //     ),
                //     (route) => false);
                Get.offNamed(RouteName.TEACHER_LOGIN);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Login sebagai ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Ustad',
                    style: TextStyle(
                      color: ColorAsset.ORANGE,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                // Navigator.of(context).pushAndRemoveUntil(
                //     MaterialPageRoute(
                //       builder: (context) => const ParentLoginPage(),
                //     ),
                //     (route) => false);
                Get.offNamed(RouteName.PARENT_LOGIN);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Login sebagai ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Orang Tua',
                    style: TextStyle(
                      color: ColorAsset.ORANGE,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
