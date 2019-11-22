import 'dart:core';

class User {
  String nickname;
  String email;
  String photoUrl;
  String password;
  String height;
  String weight;
  String hairStyle;
  String waist;

  String userType;

  String subscription;

  String gender;

  String country;
  String userId;

  String phone;

  String hairColor;

  String eyeColor;

  String chest;

  String shoeSize;

  String dressSize;

  String ethnicity;

  String about;
  String skills;

  String video;

  String age;

  User();

  User.create(
      this.nickname,
      this.email,
      this.photoUrl,
      this.password,
      this.height,
      this.weight,
      this.hairStyle,
      this.waist,
      this.userType,
      this.subscription,
      this.gender,
      this.country,
      this.phone,
      this.hairColor,
      this.eyeColor,
      this.shoeSize,
      this.dressSize,
      this.ethnicity,
      this.about,
      this.skills,
      this.video,
      this.age,
      this.chest,
  {this.userId});

  toJson() {
    return {
      "nickname": nickname,
      "email": email,
      "photoUrl": photoUrl,
      "password": password,
      "height": height,
      "weight": weight,
      "hairStyle": hairStyle,
      "waist": waist,
      "userType": userType,
      "subscription": subscription,
      "gender": gender,
      "country": country,
      "phone": phone,
      "hairColor": hairColor,
      "eyeColor": eyeColor,
      "chest": chest,
      "shoeSize": shoeSize,
      "dressSize": dressSize,
      "ethnicity": ethnicity,
      "about": about,
      "skills": skills,
      "video": video,
      "age": age,
    };
  }
}
