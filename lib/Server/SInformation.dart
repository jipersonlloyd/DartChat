import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:full_stack_practice/Model/Information.dart';
import 'package:http/http.dart' as http;

class SInformation {
  static Future<void> getInformationDataFromServer() async {
    String url = "http://jipersonlloyd-001-site1.etempurl.com/api/Employees/getData";
    String username = '11161869';
    String password = '60-dayfreetrial';
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'authorization': basicAuth}
      );

      if(response.statusCode == 200) {
        debugPrint('response: $response');
      }
    } catch (e) {
      debugPrint('Error in gettingInformationFromServer: $e');
    }
  }
}
