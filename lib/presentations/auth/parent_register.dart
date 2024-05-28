import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getX;
import 'package:image_picker/image_picker.dart';
import 'package:testing/blocs/auth/register/register_bloc.dart';
import 'package:testing/blocs/auth/register/register_event.dart';
import 'package:testing/blocs/auth/register/register_state.dart';
import 'package:testing/blocs/indonesia-area/district/district_bloc.dart';
import 'package:testing/blocs/indonesia-area/district/district_event.dart';
import 'package:testing/blocs/indonesia-area/district/district_state.dart';
import 'package:testing/blocs/indonesia-area/province/province_bloc.dart';
import 'package:testing/blocs/indonesia-area/province/province_event.dart';
import 'package:testing/blocs/indonesia-area/province/province_state.dart';
import 'package:testing/blocs/indonesia-area/regency/regency_bloc.dart';
import 'package:testing/blocs/indonesia-area/regency/regency_event.dart';
import 'package:testing/blocs/indonesia-area/regency/regency_state.dart';
import 'package:testing/blocs/indonesia-area/village/village_bloc.dart';
import 'package:testing/blocs/indonesia-area/village/village_event.dart';
import 'package:testing/blocs/indonesia-area/village/village_state.dart';
import 'package:testing/blocs/master/all-student/all_student_bloc.dart';
import 'package:testing/blocs/master/all-student/all_student_event.dart';
import 'package:testing/blocs/master/all-student/all_student_state.dart';
import 'package:testing/utils/ColorAsset.dart';

class ParentRegisterPage extends StatefulWidget {
  const ParentRegisterPage({super.key});

  @override
  State<ParentRegisterPage> createState() => _ParentRegisterPageState();
}

class _ParentRegisterPageState extends State<ParentRegisterPage> {
  late AllStudentBloc allStudentBloc;
  late RegisterBloc registerBloc;
  late ProvinceBloc provinceBloc;
  late RegencyBloc regencyBloc;
  late DistrictBloc districtBloc;
  late VillageBloc villageBloc;

  TextEditingController _name = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _nik = TextEditingController();
  TextEditingController _birthPlace = TextEditingController();
  TextEditingController _birthDate = TextEditingController();
  TextEditingController _studentBirthPlace = TextEditingController();
  TextEditingController _studentBirthDate = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  String selectedStudent = '0';
  String selectedProvince = '0';
  String selectedRegency = '0';
  String selectedDistrict = '0';
  String selectedVillage = '0';

  bool isPasswordVisible = false;

  List<DropdownMenuItem<String>> students = [
    DropdownMenuItem(child: Text('Santri A'), value: 'a'),
    DropdownMenuItem(child: Text('Santri B'), value: 'b'),
    DropdownMenuItem(child: Text('Santri C'), value: 'c'),
    DropdownMenuItem(child: Text('Santri D'), value: 'd'),
    DropdownMenuItem(child: Text('Santri E'), value: 'e'),
    DropdownMenuItem(child: Text('Santri F'), value: 'f'),
  ];

  File? image = null;
  Future pickImage() async {
    final result = await ImagePicker().getImage(source: ImageSource.gallery);

    if (result != null) {
      print('PICKED: ${result.path}');
      setState(() {
        image = File(result.path);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allStudentBloc = BlocProvider.of<AllStudentBloc>(context);
    allStudentBloc.add(OnGetAllStudent());

    registerBloc = BlocProvider.of<RegisterBloc>(context);

    provinceBloc = BlocProvider.of<ProvinceBloc>(context);
    provinceBloc.add(OnGetProvince());

    regencyBloc = BlocProvider.of<RegencyBloc>(context);

    districtBloc = BlocProvider.of<DistrictBloc>(context);

    villageBloc = BlocProvider.of<VillageBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
        left: 24,
        top: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(100),
            ),
            margin: const EdgeInsets.only(bottom: 24),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(bottom: 4),
                child: const Text(
                  'Selamat datang,',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: ColorAsset.GREEN,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(bottom: 24),
                child: const Text(
                  'Silahkan daftarkan identitas Anda',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: ColorAsset.GREEN,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      // enabledBorder: UnderlineInputBorder(
                      //   borderSide: BorderSide(
                      //     color: Colors.black,
                      //   ),
                      // ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      labelText: 'Nama Lengkap',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      hintText: 'Nama Lengkap',
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextFormField(
                    controller: _username,
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      // enabledBorder: UnderlineInputBorder(
                      //   borderSide: BorderSide(
                      //     color: Colors.black,
                      //   ),
                      // ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      hintText: 'Username',
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextFormField(
                    controller: _nik,
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      // enabledBorder: UnderlineInputBorder(
                      //   borderSide: BorderSide(
                      //     color: Colors.black,
                      //   ),
                      // ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      labelText: 'NIK',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      hintText: '123xxxxxxxxx',
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  // TextFormField(
                  //   decoration: const InputDecoration(
                  //     border: UnderlineInputBorder(
                  //       borderSide: BorderSide(
                  //         color: Colors.grey,
                  //       ),
                  //     ),
                  //     // enabledBorder: UnderlineInputBorder(
                  //     //   borderSide: BorderSide(
                  //     //     color: Colors.black,
                  //     //   ),
                  //     // ),
                  //     focusedBorder: UnderlineInputBorder(
                  //       borderSide: BorderSide(
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  //     labelText: 'Nama Anak/Santri',
                  //     labelStyle: TextStyle(
                  //       color: Colors.grey,
                  //     ),
                  //     hintText: 'Nama Anak/Santri',
                  //   ),
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.w700,
                  //   ),
                  // ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: const Text(
                      'Nama Anak/Santri',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  BlocBuilder<AllStudentBloc, AllStudentState>(
                    builder: (context, state) {
                      if (state is AllStudentSuccess) {
                        if (selectedStudent == '0') {
                          selectedStudent =
                              state.allStudentModel.data[0].id.toString();
                        }

                        return DropdownButton(
                          isExpanded: true,
                          value: selectedStudent,
                          items: state.allStudentModel.data.map((val) {
                            return DropdownMenuItem(
                              value: val.id.toString(),
                              child: Text(val.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedStudent = value.toString();
                            });
                          },
                        );
                      } else if (state is AllStudentError) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: const Text('Data Kosong'),
                        );
                      }
                      return Container(
                        width: 16,
                        height: 16,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: const CircularProgressIndicator(
                          color: ColorAsset.GREEN,
                        ),
                      );
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _birthPlace,
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            // enabledBorder: UnderlineInputBorder(
                            //   borderSide: BorderSide(
                            //     color: Colors.black,
                            //   ),
                            // ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            labelText: 'Tempat Lahir',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            hintText: 'Tempat Lahir',
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _birthDate,
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            // enabledBorder: UnderlineInputBorder(
                            //   borderSide: BorderSide(
                            //     color: Colors.black,
                            //   ),
                            // ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            labelText: 'Tanggal Lahir',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            hintText: 'dd-MM-YYYY',
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _studentBirthDate,
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            // enabledBorder: UnderlineInputBorder(
                            //   borderSide: BorderSide(
                            //     color: Colors.black,
                            //   ),
                            // ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            labelText: 'Tanggal Lahir Santri',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            hintText: 'dd-MM-YYYY',
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _studentBirthPlace,
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            // enabledBorder: UnderlineInputBorder(
                            //   borderSide: BorderSide(
                            //     color: Colors.black,
                            //   ),
                            // ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            labelText: 'Tempat Lahir Santri',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            hintText: 'Tempat Lahir Santri',
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: const Text(
                      'Provinsi',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  BlocBuilder<ProvinceBloc, ProvinceState>(
                    builder: (context, state) {
                      if (state is ProvinceSuccess) {
                        if (selectedProvince == '0') {
                          selectedProvince =
                              state.provinceModel.data[0].id.toString();
                          regencyBloc
                              .add(OnGetRegency(selectedProvince.toString()));
                        }

                        return DropdownButton(
                          isExpanded: true,
                          value: selectedProvince,
                          items: state.provinceModel.data.map((val) {
                            return DropdownMenuItem(
                              value: val.id.toString(),
                              child: Text(val.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedProvince = value!.toString();

                              regencyBloc.emit(RegencyInitial());
                              districtBloc.emit(DistrictInitial());
                              villageBloc.emit(VillageInitial());

                              selectedRegency = '0';
                              selectedDistrict = '0';
                              selectedVillage = '0';

                              regencyBloc.add(
                                  OnGetRegency(selectedProvince.toString()));
                            });
                          },
                        );
                      } else if (state is ProvinceError) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: const Text('Data Kosong'),
                        );
                      }
                      return Container(
                        width: 16,
                        height: 16,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: const CircularProgressIndicator(
                          color: ColorAsset.GREEN,
                        ),
                      );
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: const Text(
                      'Kabupaten',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  BlocBuilder<RegencyBloc, RegencyState>(
                    builder: (context, state) {
                      if (state is RegencySuccess) {
                        if (selectedRegency == '0') {
                          selectedRegency =
                              state.regencyModel.data[0].id.toString();
                          districtBloc
                              .add(OnGetDistrict(selectedRegency.toString()));
                        }

                        return DropdownButton(
                          isExpanded: true,
                          value: selectedRegency,
                          items: state.regencyModel.data.map((val) {
                            return DropdownMenuItem(
                              value: val.id.toString(),
                              child: Text(val.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedRegency = value!.toString();

                              districtBloc.emit(DistrictInitial());
                              villageBloc.emit(VillageInitial());

                              selectedDistrict = '0';
                              selectedVillage = '0';

                              districtBloc.add(
                                  OnGetDistrict(selectedRegency.toString()));
                            });
                          },
                        );
                      } else if (state is RegencyError) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: const Text('Data Kosong'),
                        );
                      }
                      return Container(
                        width: 16,
                        height: 16,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: const CircularProgressIndicator(
                          color: ColorAsset.GREEN,
                        ),
                      );
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: const Text(
                      'Kecamatan',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  BlocBuilder<DistrictBloc, DistrictState>(
                    builder: (context, state) {
                      if (state is DistrictSuccess) {
                        if (selectedDistrict == '0') {
                          selectedDistrict =
                              state.districtModel.data[0].id.toString();
                          villageBloc
                              .add(OnGetVillage(selectedDistrict.toString()));
                        }

                        return DropdownButton(
                          isExpanded: true,
                          value: selectedDistrict,
                          items: state.districtModel.data.map((val) {
                            return DropdownMenuItem(
                              value: val.id.toString(),
                              child: Text(val.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDistrict = value!.toString();

                              villageBloc.emit(VillageInitial());

                              selectedVillage = '0';

                              villageBloc.add(
                                  OnGetVillage(selectedDistrict.toString()));
                            });
                          },
                        );
                      } else if (state is DistrictError) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: const Text('Data Kosong'),
                        );
                      }
                      return Container(
                        width: 16,
                        height: 16,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: const CircularProgressIndicator(
                          color: ColorAsset.GREEN,
                        ),
                      );
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: const Text(
                      'Kelurahan',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  BlocBuilder<VillageBloc, VillageState>(
                    builder: (context, state) {
                      if (state is VillageSuccess) {
                        if (selectedVillage == '0') {
                          selectedVillage =
                              state.villageModel.data[0].id.toString();
                        }

                        return DropdownButton(
                          isExpanded: true,
                          value: selectedVillage,
                          items: state.villageModel.data.map((val) {
                            return DropdownMenuItem(
                              value: val.id.toString(),
                              child: Text(val.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedVillage = value!.toString();
                            });
                          },
                        );
                      } else if (state is VillageError) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: const Text('Data Kosong'),
                        );
                      }
                      return Container(
                        width: 16,
                        height: 16,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: const CircularProgressIndicator(
                          color: ColorAsset.GREEN,
                        ),
                      );
                    },
                  ),
                  TextFormField(
                    controller: _address,
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      // enabledBorder: UnderlineInputBorder(
                      //   borderSide: BorderSide(
                      //     color: Colors.black,
                      //   ),
                      // ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      labelText: 'Detail Alamat',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      hintText: 'Detail Alamat',
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: const Text(
                      'Gambar KTP',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await pickImage();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      margin: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                        image: image != null
                            ? DecorationImage(
                                image: FileImage(image!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_search_rounded,
                            size: 28,
                          ),
                          SizedBox(height: 8),
                          const Text('Tambah Gambar'),
                        ],
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      // enabledBorder: UnderlineInputBorder(
                      //   borderSide: BorderSide(
                      //     color: Colors.black,
                      //   ),
                      // ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      labelText: 'Email address',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      hintText: 'Email address',
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextFormField(
                    controller: _password,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      // enabledBorder: UnderlineInputBorder(
                      //   borderSide: BorderSide(
                      //     color: Colors.black,
                      //   ),
                      // ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        icon: isPasswordVisible
                            ? Icon(
                                Icons.visibility,
                                color: ColorAsset.GREEN,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: ColorAsset.GREEN,
                              ),
                      ),
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: ElevatedButton(
              onPressed: () async {
                // HashMap<String, dynamic> body = HashMap();
                // body['name'] = _name.text;
                // body['username'] = _username.text;
                // body['email'] = _email.text;
                // body['password'] = _password.text;

                // body['nik'] = _nik.text;
                // body['student_id'] = selectedStudent.toString();
                // body['birth_place'] = _birthPlace.text;
                // body['birth_date'] = _birthDate.text;
                // body['student_birth_place'] = _studentBirthPlace.text;
                // body['student_birth_date'] = _studentBirthDate.text;

                // body['province_id'] = selectedProvince.toString();
                // body['regency_id'] = selectedRegency.toString();
                // body['district_id'] = selectedDistrict.toString();
                // body['village_id'] = selectedVillage.toString();
                // body['address'] = _address.text;

                // body['identity_image'] = '';

                // body['role'] = 'parent';

                FormData body = FormData.fromMap({
                  'name': _name.text,
                  'username': _username.text,
                  'email': _email.text,
                  'password': _password.text,
                  'nik': _nik.text,
                  'student_id': selectedStudent.toString(),
                  'birth_place': _birthPlace.text,
                  'birth_date': _birthDate.text,
                  'student_birth_place': _studentBirthPlace.text,
                  'student_birth_date': _studentBirthDate.text,
                  'province_id': selectedProvince.toString(),
                  'regency_id': selectedRegency.toString(),
                  'district_id': selectedDistrict.toString(),
                  'village_id': selectedVillage.toString(),
                  'address': _address.text,
                  'identity_image': image != null
                      ? await MultipartFile.fromFile(image!.path)
                      : null,
                  'role': 'parent',
                });

                registerBloc.add(OnSignupRegister(body));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorAsset.GREEN,
                fixedSize: Size(
                  MediaQuery.of(context).size.width,
                  55,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  if (state is RegisterLoading) {
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
                        Text('Daftar'),
                      ],
                    );
                  } else if (state is RegisterSuccess) {
                    Future.delayed(Duration.zero, () {
                      getX.Get.back();

                      getX.Get.showSnackbar(
                        getX.GetSnackBar(
                          message: state.successModel.message,
                          icon: Icon(
                            Icons.check_circle_outline_rounded,
                            color: Colors.white,
                          ),
                          duration: Duration(seconds: 3),
                          margin: EdgeInsets.all(8),
                          backgroundColor: Colors.green,
                          borderRadius: 8,
                          snackPosition: getX.SnackPosition.TOP,
                        ),
                      );

                      registerBloc.emit(RegisterInitial());
                    });
                  } else if (state is RegisterError) {
                    Future.delayed(Duration.zero, () {
                      getX.Get.showSnackbar(
                        getX.GetSnackBar(
                          message: state.error,
                          icon: const Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.white,
                          ),
                          duration: const Duration(seconds: 3),
                          margin: const EdgeInsets.all(8),
                          backgroundColor: Colors.red,
                          borderRadius: 8,
                          snackPosition: getX.SnackPosition.TOP,
                        ),
                      );

                      registerBloc.emit(RegisterInitial());
                    });
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Daftar'),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
