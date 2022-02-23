class Profile{
  String? name;
  String? email;
  String? gender;
  int? age;
  int? follower;
  int? following;
  String? image;

  Profile(this.name, this.email, this.gender, this.age, this.follower,
      this.following, this.image);

  Profile .fromJson(Map<String,dynamic> json)
  :name = json["name"],
  email = json["email"],
  gender = json["gender"],
  age = json["gender"],
  follower = json["follower"],
  following = json["following"],
  image = json["image"];

  Map<String,dynamic> toJson() => {
    "name" : name,
    "email" : email,
    "gender" : gender,
    "age" : age,
    "follower" : follower,
    "following" : following,
    "image" : image,
  };
}