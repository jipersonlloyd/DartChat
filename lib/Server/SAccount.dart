import 'dart:convert';
import 'package:full_stack_practice/Model/UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class SAccount {
  static Future<Map<String, dynamic>> loginAccount(
      String userName, String password) async {
    Map<String, dynamic> result;
    try {
      String url =
          'http://jipersonlloyd-001-site1.etempurl.com/api/user/loginAccount';
      String authUserName = '11161869';
      String authPassword = '60-dayfreetrial';
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$authUserName:$authPassword'))}';

      final response = await http.post(Uri.parse(url),
          headers: {
            'authorization': basicAuth,
            'Content-Type': 'application/json'
          },
          body: jsonEncode({"userName": userName, "password": password}));
      dynamic res = json.decode(response.body);
      if (response.statusCode == 200) {
        result = {'status': res['Result'], 'message': res['Message']};
      } else {
        result = {'status': res['Result'], 'message': res['Message']};
      }
    } catch (e) {
      result = {'status': false, 'message': 'Error'};
    }
    return result;
  }

  static Future<Map<String, dynamic>> createAccount(String username,
      String password, String email, String phoneNumber) async {
    Map<String, dynamic> result;
    try {
      String url =
          'http://jipersonlloyd-001-site1.etempurl.com/api/user/createAccount';
      String authUserName = '11161869';
      String authPassword = '60-dayfreetrial';
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$authUserName:$authPassword'))}';

      final response = await http.post(Uri.parse(url),
          headers: {
            'authorization': basicAuth,
            'Content-Type': 'application/json'
          },
          body: json.encode({
            "userName": username,
            "password": password,
            "email": email,
            "phoneNumber": phoneNumber,
            "dateCreated": DateTime.now().toString()
          }));
      dynamic res = json.decode(response.body);
      if (response.statusCode == 200) {
        result = {'status': res['Result'], 'message': res['Message']};
      } else {
        result = {'status': res['Result'], 'message': res['Message']};
      }
    } catch (e) {
      debugPrint('Error in creating account: $e');
      result = {'status': false, 'message': 'Error'};
    }
    return result;
  }

  static Future<Map<String, dynamic>> getUserData(String username) async {
    Map<String, dynamic> result;
    UserModel? userModel;
    try {
      String url =
          'http://jipersonlloyd-001-site1.etempurl.com/api/user/data?username=$username';
      debugPrint('urlUser: $url');
      String authUserName = '11161869';
      String authPassword = '60-dayfreetrial';
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$authUserName:$authPassword'))}';
      final response = await http.get(Uri.parse(url), headers: {
        'authorization': basicAuth,
        'Content-Type': 'application/json'
      });

      var res = json.decode(response.body);
      var resMsg = res['Message'];
      if (response.statusCode == 200) {
        userModel = UserModel(
            username: resMsg['userName'],
            password: resMsg['pass'],
            email: resMsg['email'],
            phonenumber: resMsg['phoneNumber'],
            dateRegistered: resMsg['dateCreated']);
        result = {'status': true, 'value': userModel};
      } else {
        result = {'status': false, 'value': null};
      }
    } catch (e) {
      debugPrint('Error fetching Data: $e');
      result = {'status': false, 'value': null};
    }
    return result;
  }

  static Future<Map<String, dynamic>> getUsernames() async {
    Map<String, dynamic> result;
    List<String> userNamesList = [];
    try {
      String url =
          'http://jipersonlloyd-001-site1.etempurl.com/api/user/usernames';
      String authUserName = '11161869';
      String authPassword = '60-dayfreetrial';
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$authUserName:$authPassword'))}';
      final response = await http.get(Uri.parse(url), headers: {
        'authorization': basicAuth,
        'Content-Type': 'application/json'
      });

      var res = json.decode(response.body);
      var resMsg = res['Message'];
      if (response.statusCode == 200) {
        for (int i = 0; i < resMsg.length; i++) {
          userNamesList.add(resMsg[i]);
        }
        result = {'status': true, 'value': userNamesList};
      } else {
        result = {'status': false, 'value': null};
      }
    } catch (e) {
      debugPrint('Error getting usernames: $e');
      result = {'status': false, 'value': null};
    }
    return result;
  }

  static Future<Map<String, dynamic>> insertTokentoDatabase(
      String token, String username) async {
    Map<String, dynamic> result;
    try {
      String url =
          'http://jipersonlloyd-001-site1.etempurl.com/api/user/updateToken';
      String authUserName = '11161869';
      String authPassword = '60-dayfreetrial';
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$authUserName:$authPassword'))}';

      final response = await http.patch(Uri.parse(url),
          headers: {
            'authorization': basicAuth,
            'Content-Type': 'application/json'
          },
          body: json.encode({
            "username": username,
            "token": token,
          }));

      dynamic res = json.decode(response.body);
      if (response.statusCode == 200) {
        result = {'status': res['Result'], 'message': res['Message']};
      } else {
        result = {'status': res['Result'], 'message': res['Message']};
      }
    } catch (e) {
      debugPrint('Error inserting token in database: $e');
      result = {'status': false, 'message': 'Error'};
    }
    return result;
  }

  static Future<Map<String, dynamic>> getTokenFromDatabase(
      String receiverID) async {
    Map<String, dynamic> result;
    try {
      String url =
          'http://jipersonlloyd-001-site1.etempurl.com/api/user/getToken?receiverID=$receiverID';
      String authUserName = '11161869';
      String authPassword = '60-dayfreetrial';
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$authUserName:$authPassword'))}';
      final response = await http.get(Uri.parse(url), headers: {
        'authorization': basicAuth,
        'Content-Type': 'application/json'
      });
      var res = json.decode(response.body);

      if (response.statusCode == 200) {
        result = {'status': res['Result'], 'message': res['Message']};
      } else {
        result = {'status': res['Result'], 'message': res['Message']};
      }
    } catch (e) {
      debugPrint('Error getting token from database: $e');
      result = {'status': false, 'message': 'Error'};
    }
    return result;
  }
}
