import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:ussd_simulator/model/ussd_request.dart';
import 'package:ussd_simulator/model/ussd_response.dart';
import 'package:http/http.dart' as http;
import 'package:ussd_simulator/widgets/custom_alert_dialog.dart';

class UssdRepo {
  static final HttpWithMiddleware _httpClient =
      HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);

  static Future<void> sendRequest(
      UssdRequest ussdRequest, BuildContext context, String ussdPrefix) async {
    String ussdUrlPath = ussdUrl(ussdPrefix);
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await _httpClient.post(
      Uri.parse(ussdUrlPath),
      headers: requestHeaders,
      body: jsonEncode(
        ussdRequest.toJson(),
      ),
    );

    if (response.statusCode == 200) {
      UssdResponse ussdResponse =
          UssdResponse.fromJson(jsonDecode(response.body));
      CustomAlertDialog.showAlertDialog(
          myContext: context, ussdResponse: ussdResponse, ussdPrefix: ussdPrefix);
    } else {
      throw Exception('Server error');
    }
  }

  static String ussdUrl(String ussdPrefix) {
    String baseUrl = 'http://102.37.222.117:80';
    String prefix1 = 'api/ussd/process-request';
    String prefix2 = 'api/v1/ussd/process-request';
    if (ussdPrefix == "*111*") {
      return '$baseUrl/$prefix1';
    } else {
      return '$baseUrl/$prefix2';
    }
  }
}
