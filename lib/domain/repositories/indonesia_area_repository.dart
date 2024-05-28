import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:testing/domain/models/all_student_classes.dart';
import 'package:testing/domain/models/all_student_model.dart';
import 'package:testing/domain/models/classes_model.dart';
import 'package:testing/domain/models/district_model.dart';
import 'package:testing/domain/models/province_model.dart';
import 'package:testing/domain/models/regency_model.dart';
import 'package:testing/domain/models/semester_model.dart';
import 'package:testing/domain/models/study_year_model.dart';
import 'package:testing/domain/models/teacher_classes_model.dart';
import 'package:testing/domain/models/village_model.dart';
import 'package:testing/domain/repositories/repository_app.dart';

class IndonesiaAreaRepository extends RepositoryApp {
  Future<ProvinceModel> province() async {
    try {
      final response = await dio.get(
        'indonesia-area/province',
        // queryParameters: {
        //   'parent_id': parentId,
        // },
      );

      return provinceModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<RegencyModel> regency(provinceId) async {
    try {
      final response = await dio.get(
        'indonesia-area/regency',
        queryParameters: {
          'province_id': provinceId,
        },
      );

      return regencyModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<DistrictModel> district(regencyId) async {
    try {
      final response = await dio.get(
        'indonesia-area/district',
        queryParameters: {
          'regency_id': regencyId,
        },
      );

      return districtModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<VillageModel> village(districtId) async {
    try {
      final response = await dio.get(
        'indonesia-area/village',
        queryParameters: {
          'district_id': districtId,
        },
      );

      return villageModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }
}
