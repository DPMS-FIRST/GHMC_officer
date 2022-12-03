class ResendOtpResponse {
  String? otp;
  bool? status;

  ResendOtpResponse({this.otp, this.status});

  ResendOtpResponse.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['status'] = this.status;
    return data;
  }
}
