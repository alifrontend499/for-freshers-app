const String path = 'https://quiz.knowtherules.ca/api/v1/';

const String apiListAllTests = '${path}get_question_answers';
String apiGetTestQuestionsDetails(String id) => '${path}get_quiz_question_answers/$id';