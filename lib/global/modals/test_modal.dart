class TestModal {
  final String type;
  final List<TestSingleModel> allTests;

  TestModal({
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
