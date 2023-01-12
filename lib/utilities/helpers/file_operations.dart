import 'dart:convert';
import 'dart:io';

//  consts | global
import 'package:app/global/consts/global_consts.dart';

// -- models | global
import 'package:app/global/models/test_model.dart';

// -- package | path provider
import 'package:path_provider/path_provider.dart';

// functions | questions
const String completedTestsFileName = 'completedTestsByUser.txt';

Future<File> getCompletedTestsFile() async {
  Directory tempDir = await getTemporaryDirectory();
  return File("${tempDir.path}/$completedTestsFileName");
}

Future<bool> isCompletedTestsFileExist() async {
  File completedTestFile = await getCompletedTestsFile();
  return completedTestFile.exists();
}

// helper | get selected answers
// QuestionDataModel getQuestionsData(List<dynamic> dataRaw) {
//   return QuestionDataModel(
//     id: dataRaw['id'].toString(),
//     quizId: dataRaw['quizId'],
//     name: e['name'],
//     imgUrl: e['imgUrl'],
//   );
// }

// helper | get selected answers
// List<SelectedAnswerModel> getSelectedAnswers(List<dynamic> dataRaw) {
//   return dataRaw.map((e) {
//     final QuestionDataModel questionDataList = getQuestionsData(e['questionData']);
//     return SelectedAnswerModel(
//       questionId: e['questionId'],
//       questionData: questionDataList,
//       wasRight: e['wasRight'],
//       selectedOn: e['selectedOn'],
//     );
//   }).toList();
// }

Future<List<CompletedTestModel>> getCompletedTestsContent() async {
  File completedTestFile = await getCompletedTestsFile();
  final String stringDataRaw = await completedTestFile.readAsString();
  if (stringDataRaw.isNotEmpty) {
    final List<dynamic> dataRaw = jsonDecode(stringDataRaw);
    final List<CompletedTestModel> completedTestsContent = dataRaw.map(
      (e) {
        return CompletedTestModel(
          testId: e['testId'],
          testType: e['testType'],
          testName: e['testName'],
          testQuestions: e['testQuestions'],
          testDescription: e['testDescription'],
          isPremium: e['isPremium'],
          testImg: e['testImg'],
          selectedAnswers: e['selectedAnswers'],
        );
      },
    ).toList();

    return completedTestsContent;
  }
  return [];
}

Future<void> deleteCompletedTestsFile() async {
  File completedTestFile = await getCompletedTestsFile();
  completedTestFile.delete();
  print('delete complete');
}

Future<void> setCompletedTestHelper(CompletedTestModel completedTest) async {
  final isFileExist = await isCompletedTestsFileExist();
  if (isFileExist) {
    final List<CompletedTestModel> existingCompletedTests =
        await getCompletedTestsContent();
    print('existingCompletedTests $existingCompletedTests');
  } else {
    final File completedTestFile = await getCompletedTestsFile();
    final String dataToSaved = jsonEncode([completedTest.toJson()]);
    completedTestFile.writeAsString(dataToSaved);
  }
}

// Future<void> setCompletedTestHelper() async {
// }
