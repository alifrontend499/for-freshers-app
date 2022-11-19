import 'package:flutter/material.dart';

// models
import 'package:app/global/state/models/selected_answers_model.dart';

// global | state
import 'package:app/global/state/global_state.dart';

// package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

// to update selected answers
void updateSelectedAnswersProvider(WidgetRef ref, SelectedAnswerModel newItem) {
  // getting existing answers
  final List<SelectedAnswerModel> currentList = ref.read(selectedAnswersProvider);

  // adding new item
  currentList.add(newItem);

  // updating state
  ref.watch(selectedAnswersProvider.notifier).state = currentList;

  // done
  print('state updated');
}