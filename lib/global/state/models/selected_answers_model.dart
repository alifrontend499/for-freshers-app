// models
import 'package:app/screens/test_view/models/question_and_options_model.dart';

class SelectedAnswerModel {
  final String questionId;
  final QuestionModel questionData;
  final OptionsModel selectedOption;
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