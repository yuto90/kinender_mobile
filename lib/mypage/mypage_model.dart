import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kinender_mobile/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model.dart';

class MypageModel extends ChangeNotifier {
  String userName = '名前';

  // PostDateAPIの返却値をそのまま返すだけ
  Future<List> getAllEvent() async {
    // PostDateAPIを呼び出し
    http.Response eventData;
    http.Response newToken;

    // API呼び出し前にトークンをチェック
    String res = await Helper.checkToken();

    if (res != 'refreshToken Expired') {
      eventData = await Model.callGetPostDateApi();

      // 返却結果をUTF8にコンバート
      String decodeRes = utf8.decode(eventData.bodyBytes);
      List listRes = jsonDecode(decodeRes);

      return listRes;
    } else {
      return [];
    }
  }

  // 画面を更新
  void notify() {
    notifyListeners();
  }
}
