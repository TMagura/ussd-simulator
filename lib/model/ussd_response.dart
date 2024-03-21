class UssdResponse {
  String? reference;
  bool? success;
  String? message;
  String? stage;

  UssdResponse({this.reference, this.success, this.message, this.stage});

  UssdResponse.fromJson(Map<String, dynamic> json) {
    reference = json['reference'];
    success = json['success'];
    message = json['message'];
    stage = json['stage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reference'] = reference;
    data['success'] = success;
    data['message'] = message;
    data['stage'] = stage;
    return data;
  }
}
