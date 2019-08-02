class VideoModel {
  String name;
  String head;
  String record;
  String url;

  VideoModel({this.name, this.head, this.record, this.url});

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      name: json['name'],
      head: json['head'],
      record: json['record'],
      url: json['url'],
    );
  }
}

class VideoListModel {
  List<VideoModel> items;

  VideoListModel({this.items});

  factory VideoListModel.fromJson(List<dynamic> json) {
    List<VideoModel> ablumItems = new List<VideoModel>();

    json.forEach((v) {
      ablumItems.add(new VideoModel.fromJson(v));
    });

    return VideoListModel(items: ablumItems);
  }
}
