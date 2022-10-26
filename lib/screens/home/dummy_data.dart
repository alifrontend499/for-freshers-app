// -- modals | global
import 'package:app/global/modals/test_modal.dart';

final List<TestModal> ALL_EASY_TESTS = [
  TestModal(
    testType: 'Easy',
    testName: 'Practice Test 1',
    testQuestions: '10-15',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
    isPremium: false,
  ),
  TestModal(
    testType: 'Easy',
    testName: 'Practice Test 2',
    testQuestions: '15-20',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys',
    isPremium: true,
  ),
  TestModal(
    testType: 'Easy',
    testName: 'Practice Test 3',
    testQuestions: '20-25',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s',
    isPremium: false,
  ),
  TestModal(
    testType: 'Easy',
    testName: 'Practice Test 4',
    testQuestions: '30-35',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and',
    isPremium: false,
  ),
  TestModal(
    testType: 'Easy',
    testName: 'Practice Test 5',
    testQuestions: '40-45',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s',
    isPremium: false,
  ),
];

final List<TestModal> ALL_HARD_TESTS = [
  TestModal(
    testType: 'Hard',
    testName: 'Practice Test 1',
    testQuestions: '10-15',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
    isPremium: true,
  ),
  TestModal(
    testType: 'Hard',
    testName: 'Practice Test 2',
    testQuestions: '15-20',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting',
    isPremium: true,
  ),
  TestModal(
    testType: 'Hard',
    testName: 'Practice Test 3',
    testQuestions: '20-25',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys',
    isPremium: false,
  ),
];

final List<TestModal> ALL_HARDEST_TESTS = [
  TestModal(
    testType: 'Hardest',
    testName: 'Practice Test 1',
    testQuestions: '10-15',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been',
    isPremium: false,
  ),
  TestModal(
    testType: 'Hardest',
    testName: 'Practice Test 2',
    testQuestions: '15-20',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy',
    isPremium: false,
  ),
  TestModal(
    testType: 'Hardest',
    testName: 'Practice Test 3',
    testQuestions: '20-25',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s',
    isPremium: false,
  ),
];

final List<TestModal> ALL_OTHERS_TESTS = [
  TestModal(
    testType: 'Others',
    testName: 'Practice Test 1',
    testQuestions: '10-15',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum',
    isPremium: true,
  ),
  TestModal(
    testType: 'Others',
    testName: 'Practice Test 2',
    testQuestions: '15-20',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text',
    isPremium: true,
  ),
  TestModal(
    testType: 'Others',
    testName: 'Practice Test 3',
    testQuestions: '20-25',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s',
    isPremium: true,
  ),
];
