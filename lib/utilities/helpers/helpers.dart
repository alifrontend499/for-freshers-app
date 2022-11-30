// HELPERS | TEXT
// get uppercase text
String getUppercaseTextHelper(String test) => test.toUpperCase();

// get lowercase text
String getLowercaseTextHelper(String test) => test.toLowerCase();

// get capitalize text
String getCapitalizeTextHelper(String test) =>
    test[0].toUpperCase() + test.substring(1).toLowerCase();

// get percentage
double getPercentageHelper(int total, int value) {
  return value / total * 100;
}
