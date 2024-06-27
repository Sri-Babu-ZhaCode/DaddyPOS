class RegisterModel {
  String deviceUniqueId;
  String deviceName;
  String businessName;
  String businessAddress;
  String loginMobileNumber;
  String email;
  bool gst;
  String gstNumber;

  RegisterModel({
    required this.deviceUniqueId,
    required this.deviceName,
    required this.businessName,
    required this.businessAddress,
    required this.loginMobileNumber,
    required this.email,
    required this.gst,
    required this.gstNumber,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        deviceUniqueId: json["DeviceUniqueId"],
        deviceName: json["DeviceName"],
        businessName: json["BusinessName"],
        businessAddress: json["BusinessAddress"],
        loginMobileNumber: json["LoginMobileNumber"],
        email: json["Email"],
        gst: json["GST"],
        gstNumber: json["GSTNumber"],
      );

  Map<String, dynamic> toJson() => {
        "DeviceUniqueId": deviceUniqueId,
        "DeviceName": deviceName,
        "BusinessName": businessName,
        "BusinessAddress": businessAddress,
        "LoginMobileNumber": loginMobileNumber,
        "Email": email,
        "GST": gst,
        "GSTNumber": gstNumber,
      };
}
