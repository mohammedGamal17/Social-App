class CommentModel {
  late String? uId;
  late String? name;
  late String? lastName;
  late String? email;
  late String? image;
  late String? dateTime;
  late String? text;
  late String? commentImage;
  late String? coverImage;
  late String? bio;

  CommentModel({
    this.uId,
    this.name,
    this.lastName,
    this.email,
    this.dateTime,
    this.text,
    this.image,
    this.commentImage,
    this.coverImage,
    this.bio,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      uId: json['uId'],
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
      image: json['image'],
      dateTime: json['dateTime'],
      commentImage: json['commentImage'],
      text: json['text'],
      coverImage: json['coverImage'],
      bio: json['bio'],
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
    data['commentImage'] = commentImage;
    data['text'] = text;
    data['coverImage'] = coverImage;
    data['bio'] = bio;
    return data;
  }
}
