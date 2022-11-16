class TestModel {
  final String id;
  final String name;
  final String text;
  final String type;
  final String isPremium;
  final DateTime createdAt;
  final List<QuestionModel> questions;

  TestModel({
    required this.id,
    required this.name,
    required this.text,
    required this.type,
    required this.isPremium,
    required this.createdAt,
    required this.questions,
  });
}

class QuestionModel {
  final String id;
  final String quizId;
  final String name;
  final List<OptionsModel> options;

  QuestionModel({
    required this.id,
    required this.quizId,
    required this.name,
    required this.options,
  });
}

class OptionsModel {
  final String id;
  final String optionId;
  final String name;
  final String description;
  final bool isRight;

  OptionsModel({
    required this.id,
    required this.optionId,
    required this.name,
    required this.description,
    required this.isRight,
  });
}



