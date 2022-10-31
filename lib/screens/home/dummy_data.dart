// -- modals | global
import 'package:app/global/modals/test_modal.dart';


const String img1 = 'https://images.collegexpress.com/article/test-prep-timeline-high-school.jpg';
const String img2 = 'https://thumbs.dreamstime.com/b/high-school-university-student-hands-taking-exams-writing-examination-paper-answer-sheet-optical-form-standardized-test-136686809.jpg';
const String img3 = 'https://institute4learning.com/blog/wp-content/uploads/2013/02/testing.jpg';
const String img4 = 'https://www.sparkadmissions.com/wp-content/uploads/2019/10/02_What_You_Need_to_Know_About_the_SSAT-880x486.jpg';
const String img5 = 'https://fordhaminstitute.org/sites/default/files/styles/single_main_image/public/2019-01/test-scores-tell-us-something-about-school-quality-petrilli.jpg?itok=xyOyWNbF';
const String img6 = 'https://img.republicworld.com/republic-prod/stories/promolarge/xhdpi/tltkvpcrqcbwm2qm_1629961279.jpeg';
const String img7 = 'https://imageio.forbes.com/specials-images/imageserve/5fd928fe0cb59b9eb105c330/Test-with-broken-Pencil/960x0.jpg?format=jpg&width=960';
const String img8 = 'https://res.cloudinary.com/picked/image/upload/ar_16:9,c_crop/q_60,h_300,f_auto/v1597396333/cms/teaching-1597396332';
const String img9 = 'https://imageio.forbes.com/blogs-images/tomvanderark/files/2019/03/Forbes-Standardized-Testing.jpg?format=jpg&width=1200';
const String img10 = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQN9tTJwVRuRlOWeagyNg_nOc5zes2WAL0ilZ8JszZJtkLHxy0bptscboMOxVWJpSuFSFM&usqp=CAU';

final List<TestModal> ALL_EASY_TESTS = [
  TestModal(
    testId: '1',
    testType: 'Easy',
    testName: 'Practice Test 1',
    testQuestions: '10-15',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
    isPremium: false,
    testImg: img1
  ),
  TestModal(
    testId: '2',
    testType: 'Easy',
    testName: 'Practice Test 2',
    testQuestions: '15-20',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys',
    isPremium: true,
    testImg: img2
  ),
  TestModal(
    testId: '1',
    testType: 'Easy',
    testName: 'Practice Test 3',
    testQuestions: '20-25',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s',
    isPremium: false,
    testImg: img3
  ),
  TestModal(
    testId: '2',
    testType: 'Easy',
    testName: 'Practice Test 4',
    testQuestions: '30-35',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and',
    isPremium: false,
    testImg: img4
  ),
  TestModal(
    testId: '3',
    testType: 'Easy',
    testName: 'Practice Test 5',
    testQuestions: '40-45',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s',
    isPremium: false,
    testImg: img5
  ),
];

final List<TestModal> ALL_HARD_TESTS = [
  TestModal(
    testId: '1',
    testType: 'Hard',
    testName: 'Practice Test 1',
    testQuestions: '10-15',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
    isPremium: true,
    testImg: img6
  ),
  TestModal(
    testId: '2',
    testType: 'Hard',
    testName: 'Practice Test 2',
    testQuestions: '15-20',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting',
    isPremium: true,
    testImg: img7
  ),
  TestModal(
    testId: '3',
    testType: 'Hard',
    testName: 'Practice Test 3',
    testQuestions: '20-25',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys',
    isPremium: false,
    testImg: img8
  ),
];

final List<TestModal> ALL_HARDEST_TESTS = [
  TestModal(
    testId: '1',
    testType: 'Hardest',
    testName: 'Practice Test 1',
    testQuestions: '10-15',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been',
    isPremium: false,
    testImg: img9
  ),
  TestModal(
    testId: '2',
    testType: 'Hardest',
    testName: 'Practice Test 2',
    testQuestions: '15-20',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy',
    isPremium: false,
    testImg: img10
  ),
  TestModal(
    testId: '3',
    testType: 'Hardest',
    testName: 'Practice Test 3',
    testQuestions: '20-25',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s',
    isPremium: false,
    testImg: img1
  ),
];

final List<TestModal> ALL_OTHERS_TESTS = [
  TestModal(
    testId: '1',
    testType: 'Others',
    testName: 'Practice Test 1',
    testQuestions: '10-15',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum',
    isPremium: true,
    testImg: img2
  ),
  TestModal(
    testId: '2',
    testType: 'Others',
    testName: 'Practice Test 2',
    testQuestions: '15-20',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text',
    isPremium: true,
    testImg: img3
  ),
  TestModal(
    testId: '3',
    testType: 'Others',
    testName: 'Practice Test 3',
    testQuestions: '20-25',
    testDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s',
    isPremium: true,
    testImg: img4
  ),
];
