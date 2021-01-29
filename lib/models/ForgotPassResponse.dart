class ForgotPasswordResponse {
  String code;
  String message;

  ForgotPasswordResponse(this.code, this.message);

  ForgotPasswordResponse.fromJson(List<dynamic> json) {
    message = json[0];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;

    return data;
  }
}