class LoginModel {
  String refresh;
  String access;
  User user;

  LoginModel({this.refresh, this.access, this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refresh'] = this.refresh;
    data['access'] = this.access;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  String fullNames;
  String email;
  String userCategory;
  int userID;

  User({this.fullNames, this.email, this.userCategory, this.userID});

  User.fromJson(Map<String, dynamic> json) {
    fullNames = json['full_names'];
    email = json['email'];
    userCategory = json['user_category'];
    userID = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_names'] = this.fullNames;
    data['email'] = this.email;
    data['user_category'] = this.userCategory;
    data['id'] = this.userID;
    return data;
  }
}
