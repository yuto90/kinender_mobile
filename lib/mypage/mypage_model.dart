import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MypageModel extends ChangeNotifier {
  String userName = '名前';

  // MypageAPIを呼び出す
  // method: GET
  Future<dynamic> callMypageApi() async {
    Uri endpoint = Uri.parse('http://localhost:8000/api/mypage/');
    var response = await http.get(endpoint, headers: {});
    // 返却結果をUTF8にコンバート
    String decodeRes = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      return jsonDecode(decodeRes);
    } else {
      return ['error'];
    }
  }

  Future<String> getUserName() async {
    var userInfo = await callMypageApi();
    return userInfo['name'];
  }
}
