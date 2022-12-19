const String path = 'https://quiz.knowtherules.ca/api/v1/';

// apis | common
const String apiListAllTests = '${path}get_question_answers';
String apiGetTestQuestionsDetails(String id) => '${path}get_quiz_question_answers/$id';

const String apiAllTypeTestsEndPoint = 'quizes';
const String apiAllTypeTests = path + apiAllTypeTestsEndPoint;

// apis | auth
const String apiLoginEndPoint = 'user/login';
const String apiLogin = path + apiLoginEndPoint;
const String apiRegisterEndPoint = 'user/register';
const String apiRegister = path + apiRegisterEndPoint;