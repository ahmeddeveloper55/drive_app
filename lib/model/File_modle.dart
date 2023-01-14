class FileModle {
  late final String name;
  late final String url;
  late final String type;
  late final int size;
  FileModle({
    required this.name,
    required this.url,
    required this.type,
    required this.size,
  });

  FileModle.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    type = json['type'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['url'] = url;
    map['type'] = type;
    map['size'] = size;
    return map;
  }
}
