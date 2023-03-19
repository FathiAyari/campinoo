class PostModel {
  String owner;
  String ownerImage;
  String? image;
  String description;
  DateTime creationDate;

  PostModel({
    required this.owner,
    required this.ownerImage,
    this.image,
    required this.creationDate,
    required this.description,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      owner: json["owner"],
      ownerImage: json["ownerImage"],
      image: json["image"],
      description: json["description"],
      creationDate: json["creationDate"].toDate(),
    );
  }
  Map<String, dynamic> Tojson() {
    return {
      "owner": owner,
      "image": image,
      "description": description,
      "creationDate": creationDate,
      "ownerImage": ownerImage,
    };
  }
}
