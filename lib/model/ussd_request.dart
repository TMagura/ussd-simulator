class UssdRequest {
  String? reference;
  String? phoneNumber;
  String? message;
  String? stage;

  UssdRequest({this.reference, this.phoneNumber, this.message, this.stage});

  UssdRequest.fromJson(Map<String, dynamic> json) {
    reference = json['reference'];
    phoneNumber = json['phoneNumber'];
    message = json['message'];
    stage = json['stage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reference'] = reference;
    data['phoneNumber'] = phoneNumber;
    data['message'] = message;
    data['stage'] = stage;
    return data;
  }
}
