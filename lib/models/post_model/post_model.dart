class PostModel {
  late String ?uId;
  late String ?name;
  late String ?lastName;
  late String ?email;
  late String ?image;
  late String ?dateTime;
  late String ?text;
  late String? postImage;

  PostModel({
     this.uId,
     this.name,
     this.lastName,
     this.email,
     this.dateTime,
     this.text,
     this.image,
    this.postImage,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      uId: json['uId'],
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
      image: json['image'],
      dateTime: json['dateTime'],
      postImage: json['postImage'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uId'] = uId;
    data['name'] = name;
    data['lastName'] = lastName;
    data['email'] = email;
    data['image'] = image;
    data['dateTime'] = dateTime;
    data['postImage'] = postImage;
    data['text'] = text;
    return data;
  }
}
