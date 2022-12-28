// models
import 'package:app/global/models/test_model.dart';

class HomeTestModel {
  final String testType;
  final String totalTests;
  final List<TestViewModel> allTests;

  HomeTestModel({
    required this.testType,
    required this.totalTests,
    required this.allTests,
  });

}