// consts | global
import 'package:app/global/consts/global_consts.dart';
import 'package:app/global/models/test_model.dart';

// package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

// selected answers state
final selectedAnswersProvider = StateProvider<List<SelectedAnswerModel>>((ref) => []); // all the answers selected byt the user will be in this.
final isAnswerSelectedProvider = StateProvider<bool>((ref) => false); // when a single answer is selected
final ongoingTestProvider = StateProvider<TestModel?>((ref) => null); // to store the test user is on currently
final ongoingTestSummary = StateProvider<TestModel?>((ref) => null); // to store the test user is on currently

// routes
final activeRouteNameProvider = StateProvider<String?>((ref) => GLOBAL_ROUTE_ID_HOME);