// modal | for a single test to test view
import 'dart:convert';

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

// modal | for a complete test that includes all the questions details as well
class CompletedTestModel {
  final int testId;
  final String testType;
  final String testName;
  final String testQuestions;
  final String testDescription;
  final bool isPremium;
  final String testImg;
  final List<SelectedAnswerModel> selectedAnswers;
  final DateTime completedOn;
  final int rightAnswersCount;

  CompletedTestModel({
    required this.testId,
    required this.testType,
    required this.testName,
    required this.testQuestions,
    required this.testDescription,
    required this.isPremium,
    required this.testImg,
    required this.selectedAnswers,
    required this.completedOn,
    required this.rightAnswersCount,
  });

  factory CompletedTestModel.fromJson(Map<String, dynamic> json) {
    List<SelectedAnswerModel> selectedAnswersData = [];
    json['selectedAnswers'].forEach((e) => selectedAnswersData.add(SelectedAnswerModel.fromJson(e)));
    return CompletedTestModel(
      testId: json['testId'],
      testType: json['testType'],
      testName: json['testName'],
      testQuestions: json['testQuestions'],
      testDescription: json['testDescription'],
      isPremium: json['isPremium'],
      testImg: json['testImg'],
      selectedAnswers: selectedAnswersData,
      completedOn: DateTime.parse(json['completedOn']),
      rightAnswersCount: json['rightAnswersCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'testId': testId,
      'testType': testType,
      'testName': testName,
      'testQuestions': testQuestions,
      'testDescription': testDescription,
      'isPremium': isPremium,
      'testImg': testImg,
      'selectedAnswers': selectedAnswers.map((e) => e.toJson()).toList(),
      'completedOn': completedOn.toIso8601String(),
      'rightAnswersCount': rightAnswersCount,
    };
  }
}

// modal | for screen where user can click start test button
class TestViewModel {
  final String type;
  final List<TestModel> allTests;

  TestViewModel({
    required this.type,
    required this.allTests,
  });

  Map<String, dynamic> toJson() => {
    'type': type,
    'allTests': allTests.map((e) => e.toJson()).toList(),
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

  factory QuestionDataModel.fromJson(Map<String, dynamic> json) {
    final List<OptionsDataModel> optionsRaw = [];
    json['options'].forEach((e) => optionsRaw.add(OptionsDataModel.fromJson(e)));
    return QuestionDataModel(
      id: json['id'],
      quizId: json['quizId'],
      name: json['name'],
      imgUrl: json['imgUrl'],
      options: optionsRaw,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'quizId': quizId,
    'name': name,
    'imgUrl': imgUrl,
    'options': options.map((e) => e.toJson()).toList(),
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

  factory OptionsDataModel.fromJson(Map<String, dynamic> json) {
    return OptionsDataModel(
      id: json['id'],
      optionId: json['optionId'],
      name: json['name'],
      description: json['description'],
      isRight: json['isRight'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'optionId': optionId,
    'name': name,
    'description': description,
    'isRight': isRight,
  };
}

// model | for a single answer selected
class SelectedAnswerModel {
  final String questionId;
  final QuestionDataModel questionData;
  final OptionsDataModel selectedOption;
  final bool wasRight;
  final DateTime selectedOn;

  SelectedAnswerModel({
    required this.questionId,
    required this.questionData,
    required this.selectedOption,
    required this.wasRight,
    required this.selectedOn,
  });

  factory SelectedAnswerModel.fromJson(Map<String, dynamic> json) {
    return SelectedAnswerModel(
      questionId: json['questionId'],
      questionData: QuestionDataModel.fromJson(json['questionData']),
      selectedOption: OptionsDataModel.fromJson(json['selectedOption']),
      wasRight: json['wasRight'],
      selectedOn: DateTime.parse(json['selectedOn']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'questionData': questionData.toJson(),
      'selectedOption': selectedOption.toJson(),
      'wasRight': wasRight,
      'selectedOn': selectedOn.toIso8601String(),
    };
  }
}