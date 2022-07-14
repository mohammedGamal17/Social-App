class UserModel {
  late String? uId;
  late String? name;
  late String email;
  late String password;
  late String? phone;
  late String? image;
  late bool? isEmailVerified;
  late String? bio;
  late String? coverImage;

  UserModel({
    this.name,
    this.phone,
    required this.email,
    required this.password,
    this.uId,
    this.image,
    this.isEmailVerified,
    this.bio,
    this.coverImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      password: json['password'],
      uId: json['uId'],
      image: json['image'],
      isEmailVerified: json['isEmailVerified'],
      bio: json['bio'],
      coverImage: json['coverImage'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    data['uId'] = uId;
    data['image'] = image;
    data['isEmailVerified'] = isEmailVerified;
    data['bio'] = bio;
    data['coverImage'] = coverImage;
    return data;
  }
}
