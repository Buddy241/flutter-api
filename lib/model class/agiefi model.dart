class ip11 {
  int? count;
  String? name;
  int? age;

  ip11({this.count, this.name, this.age});

  ip11.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    name = json['name'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['name'] = this.name;
    data['age'] = this.age;
    return data;
  }
}