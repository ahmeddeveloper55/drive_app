/*
   Model Package
 */
class FileModle {
  late final String name;
  late final String url;
  late final String id;
  late final String type;
  late final int size;
  // late bool isLiked;
  FileModle({
    required this.name,
    required this.url,
    required this.id,
    required this.type,
    required this.size,
    // this.isLiked=false
  });
  FileModle copyWith({String? id, String? name, String? type, String? url}) {
    return FileModle(name: name ?? this.name, url: url??this.url, id: id??this.id, type: type??this.type, size: size);
  }

  FileModle.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    id = json['id'];
    type = json['type'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['url'] = url;
    map['id'] = id;
    map['type'] = type;
    map['size'] = size;
    return map;
  }
}
