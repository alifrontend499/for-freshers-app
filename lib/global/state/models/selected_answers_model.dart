// -- models | global
import 'package:app/global/models/test_model.dart';

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
}