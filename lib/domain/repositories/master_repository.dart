import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:testing/domain/models/all_student_classes.dart';
import 'package:testing/domain/models/all_student_model.dart';
import 'package:testing/domain/models/classes_model.dart';
import 'package:testing/domain/models/semester_model.dart';
import 'package:testing/domain/models/study_year_model.dart';
import 'package:testing/domain/models/teacher_classes_model.dart';
import 'package:testing/domain/repositories/repository_app.dart';

class MasterRepository extends RepositoryApp {
  Future<ClassesModel> classes(String? parentId) async {
    try {
      dio.options.headers['auth-token'] = true;
      final response = await dio.get(
        'master/classes',
        queryParameters: {
          'parent_id': parentId,
        },
      );

      return classesModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<SemesterModel> semester() async {
    try {
      dio.options.headers['auth-token'] = true;
      final response = await dio.get('master/semester');

      return semesterModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<AllStudentModel> all_student() async {
    try {
      // dio.options.headers['auth-token'] = true;
      final response = await dio.get('master/all-student');

      return allStudentModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<StudyYearModel> study_year() async {
    try {
      dio.options.headers['auth-token'] = true;
      final response = await dio.get('master/study-year');

      return studyYearModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<TeacherClassesModel> teacher_classes(
      String? semester, String? studyYear) async {
    try {
      dio.options.headers['auth-token'] = true;
      final response = await dio.get(
        'master/teacher-classes',
        queryParameters: {
          'semester': semester,
          'study_year': studyYear,
        },
      );

      return teacherClassesModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<AllStudentClassesModel> all_student_classes(
      String? classes, String? studyYear) async {
    try {
      dio.options.headers['auth-token'] = true;
      final response = await dio.get(
        'master/all-student-classes',
        queryParameters: {
          'class': classes,
          'study_year': studyYear,
        },
      );

      return allStudentClassesModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }
}
