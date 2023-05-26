// ignore_for_file: non_constant_identifier_names, unused_local_variable, body_might_complete_normally_nullable
// ignore: camel_case_types

import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';
// ignore: unused_import
// import 'package:gofid_mobile_fix/Models/login_user.dart';
import 'package:gofid_mobile_fix/Models/user.dart';
import 'package:gofid_mobile_fix/Config/global.dart';

class AuthRepository {
  Future<User?> login(
      {required String EMAIL_USER, required String PASSWORD_USER}) async {
    String apiURL = '$url/loginMobile2';
    try {
      var apiResult = await http.post(
        Uri.parse(apiURL),
        body: {'EMAIL_USER': EMAIL_USER, 'PASSWORD_USER': PASSWORD_USER},
      );
      if (apiResult.statusCode == 200) {
        var jsonObject = json.decode(apiResult.body);
        inspect(jsonObject);
        return User.fromJson(jsonObject['data']);
      } else if (apiResult.statusCode == 400) {
        var jsonObject = json.decode(apiResult.body);
      }
    } catch (e) {
      return null;
    }
  }
}
