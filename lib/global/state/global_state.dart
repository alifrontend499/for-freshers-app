// package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

// models
import 'package:app/global/state/models/selected_answers_model.dart';

// selected answers state
final selectedAnswersProvider = StateProvider<List<SelectedAnswerModel>>((ref) => []);
final isAnswerSelectedProvider = StateProvider<bool>((ref) => false);
final isQuestionCompletedProvider = StateProvider<bool>((ref) => false);