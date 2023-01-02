const String CANCEL_TEST = 'Cancel';
const String TEST_ACTION_NEXT = 'Next';
const String TEST_ACTION_PREV = 'Prev';
const String TEST_ACTION_SUBMIT = 'Submit';

// dialog
const String HEADING_CANCEL_TEST = 'Confirm Cancel';
const String DESCRIPTION_CANCEL_TEST = 'Are you sure you want to cancel? All your progress will be lost.';
const String ACTION_CONTINUE_CANCEL_TEST = 'Continue with the test';
const String ACTION_CONFIRM_CANCEL_TEST = 'Confirm Cancel';

// result page
const String RESULT_PAGE_HEADING = 'You have completed the test with';
String RESULT_PAGE_HEADING_OTHER(String percentage) => 'Total score of $percentage%';
const String RESULT_PAGE_QUESTIONS_RIGHT = 'Questions right';
const String RESULT_PAGE_RETRY_TEST = 'Retry Test';
const String RESULT_PAGE_OTHER_TESTS = 'Explore Other Tests';
const String RESULT_PAGE_TEST_PASSED = 'PASSED';
const String RESULT_PAGE_TEST_FAILED = 'FAILED';
String RESULT_PAGE_PASSED_TEST_MSG(String percentage) => 'You have passed the test with $percentage% total score.';
String RESULT_PAGE_FAILED_TEST_MSG(String passPercentage) => 'You should score at least $passPercentage percent to pass the test. you can always try again.';
const String RESULT_PAGE_TEST_SUMMARY = 'View Test Summary';
