class TestModel {
  String? type;
  List<Items>? items;

  TestModel({this.type, this.items});

  TestModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }
}

class Items {
  String? testType;
  String? testName;
  String? testQuestions;

  Items({this.testType, this.testName, this.testQuestions});

  Items.fromJson(Map<String, dynamic> json) {
    testType = json['testType'];
    testName = json['testName'];
    testQuestions = json['testQuestions'];
  }
}