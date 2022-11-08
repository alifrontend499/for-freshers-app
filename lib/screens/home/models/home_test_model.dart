// models
import 'package:app/global/modals/test_modal.dart';

class HomeTestModel {
  final String testType;
  final String totalTests;
  final List<TestModal> allTests;

  HomeTestModel({
    required this.testType,
    required this.totalTests,
    required this.allTests,
  });

}