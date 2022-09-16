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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['testType'] = testType;
    data['testName'] = testName;
    data['testQuestions'] = testQuestions;
    return data;
  }
}