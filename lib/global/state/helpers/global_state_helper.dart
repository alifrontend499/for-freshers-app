import 'package:flutter/material.dart';

// global | state
import 'package:app/global/state/global_state.dart';

// package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/test_model.dart';

// to update selected answers
void updateSelectedAnswersProviderGlobalHelper(WidgetRef ref, SelectedAnswerModel newItem) {
  // getting existing answers
  final List<SelectedAnswerModel> currentList = ref.read(selectedAnswersProvider);

  // adding new item
  currentList.add(newItem);

  // updating state
  ref.watch(selectedAnswersProvider.notifier).state = currentList;

  // done
  print('state updated');
}

// when test is completed
void retryTestGlobalHelper(WidgetRef ref) {
  // updating state
  ref.watch(selectedAnswersProvider.notifier).state = [];
  ref.watch(isAnswerSelectedProvider.notifier).state = false;

  // done
  print('state updated');
}

// when test is completed
void testCanceledGlobalHelper(WidgetRef ref) {
  // updating state
  ref.watch(selectedAnswersProvider.notifier).state = [];
  ref.watch(isAnswerSelectedProvider.notifier).state = false;

  // done
  print('state updated');
}

// when test is completed
void testCompleteGlobalHelper(WidgetRef ref) {
  // updating state
  ref.watch(selectedAnswersProvider.notifier).state = [];
  ref.watch(isAnswerSelectedProvider.notifier).state = false;
  ref.watch(ongoingTestProvider.notifier).state = null;

  // done
  print('state updated');
}