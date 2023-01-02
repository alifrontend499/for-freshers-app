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
  return File("$tempDir/$completedTestsFileName");
}

Future<bool> isCompletedTestsFileExist() async {
  File completedTestFile = await getCompletedTestsFile();
  return completedTestFile.exists();
}
Future<String> getCompletedTestsContent() async {
  File completedTestFile = await getCompletedTestsFile();
  return completedTestFile.readAsString();
}

Future<void> setCompletedTestHelper(TestModel testData) async {
}

// Future<void> setCompletedTestHelper() async {
// }