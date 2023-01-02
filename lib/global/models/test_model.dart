// modals
import 'package:app/global/state/models/selected_answers_model.dart';

// modal | for a single test to test view
class TestModel {
  final int testId;
  final String testType;
  final String testName;
  final String testQuestions;
  final String testDescription;
  final bool isPremium;
  final String testImg;

  TestModel({
    required this.testId,
    required this.testType,
    required this.testName,
    required this.testQuestions,
    required this.testDescription,
    required this.isPremium,
    required this.testImg,
  });
}

class CompletedTestModal {
  final int testId;
  final String testType;
  final String testName;
  final String testQuestions;
  final String testDescription;
  final bool isPremium;
  final String testImg;
  final List<SelectedAnswerModel> selectedAnswers;

  CompletedTestModal({
    required this.testId,
    required this.testType,
    required this.testName,
    required this.testQuestions,
    required this.testDescription,
    required this.isPremium,
    required this.testImg,
    required this.selectedAnswers,
  });
}

// modal | for screen where user can click start test button
class TestViewModel {
  final String type;
  final List<TestModel> allTests;

  TestViewModel({
    required this.type,
    required this.allTests,
  });
}

// modal | for a complete test that includes all the questions details as well
class CompletedTestModel {
  final int testId;
  final String testType;
  final String testName;
  final String testQuestions;
  final String testDescription;
  final bool isPremium;
  final String testImg;

  CompletedTestModel({
    required this.testId,
    required this.testType,
    required this.testName,
    required this.testQuestions,
    required this.isPremium,
    required this.testDescription,
    required this.testImg,
  });

  Map<String, dynamic> toJson() => {
    'testId': testId,
    'testType': testType,
    'testName': testName,
    'testQuestions': testQuestions,
    'testDescription': testDescription,
    'isPremium': isPremium,
    'testImg': testImg,
  };
}

// modal | for a single question from the test
class QuestionDataModel {
  final String id;
  final String quizId;
  final String name;
  final String imgUrl;
  final List<OptionsDataModel> options;

  QuestionDataModel({
    required this.id,
    required this.quizId,
    required this.name,
    required this.imgUrl,
    required this.options,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'quizId': quizId,
    'name': name,
    'imgUrl': imgUrl,
    'options': options,
  };
}

// modal | for a single options from the question
class OptionsDataModel {
  final String id;
  final String optionId;
  final String name;
  final String description;
  final bool isRight;

  OptionsDataModel({
    required this.id,
    required this.optionId,
    required this.name,
    required this.description,
    required this.isRight,
  });
}