class TestViewModel {
  final String type;
  final List<TestSingleModel> allTests;

  TestViewModel({
    required this.type,
    required this.allTests,
  });
}

class TestSingleModel {
  final int testId;
  final String testType;
  final String testName;
  final String testQuestions;
  final String testDescription;
  final bool isPremium;
  final String testImg;

  TestSingleModel({
    required this.testId,
    required this.testType,
    required this.testName,
    required this.testQuestions,
    required this.testDescription,
    required this.isPremium,
    required this.testImg,
  });
}

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
}

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