import 'dart:convert';

List<FacilityProfileModel> facilityProfileModelFromJson(String str) =>
    List<FacilityProfileModel>.from(json.decode(str).map((x) => FacilityProfileModel.fromJson(x)));

String facilityProfileModelToJson(List<FacilityProfileModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FacilityProfileModel {
  int id;
  String facilityName;
  String facilityType;
  String overview;
  String country;
  bool available;
  String location;
  String phoneNumber;
  String profileImgUrl;
  String coverImgUrl;

  FacilityProfileModel(
      {this.id,
      this.facilityName,
      this.facilityType,
      this.overview,
      this.country,
      this.available,
      this.location,
      this.phoneNumber,
      this.profileImgUrl,
      this.coverImgUrl});

  FacilityProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    facilityName = json['facility_name'];
    facilityType = json['facility_type'];
    overview = json['overview'];
    country = json['country'];
    available = json['available'];
    location = json['location'];
    phoneNumber = json['phone_number'];
    profileImgUrl = json['profile_img_url'];
    coverImgUrl = json['cover_img_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['facility_name'] = this.facilityName;
    data['facility_type'] = this.facilityType;
    data['overview'] = this.overview;
    data['country'] = this.country;
    data['available'] = this.available;
    data['location'] = this.location;
    data['phone_number'] = this.phoneNumber;
    data['profile_img_url'] = this.profileImgUrl;
    data['cover_img_url'] = this.coverImgUrl;
    return data;
  }
}
