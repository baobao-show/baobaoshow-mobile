class AblumModel {
  String name;
  String head;
  String record;
  String cover;

  AblumModel({this.name, this.head, this.record, this.cover});

  factory AblumModel.fromJson(Map<String, dynamic> json) {
    return AblumModel(
      name: json['name'],
      head: json['head'],
      record: json['record'],
      cover: json['cover'],
    );
  }
}

class AblumListModel {
  List<AblumModel> items;

  AblumListModel({this.items});

  factory AblumListModel.fromJson(List<dynamic> json) {
    List<AblumModel> ablumItems = new List<AblumModel>();

    json.forEach((v) {
      ablumItems.add(new AblumModel.fromJson(v));
    });

    return AblumListModel(items: ablumItems);
  }
}
