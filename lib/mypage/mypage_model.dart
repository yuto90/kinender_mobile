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
    eventData = await Model.callGetPostDateApi();

    if (eventData.statusCode != 200) {
      newToken = await Model.callTokenRefreshApi();
      await Helper.setNewToken(newToken);
      eventData = await Model.callGetPostDateApi();
    }

    // 返却結果をUTF8にコンバート
    String decodeRes = utf8.decode(eventData.bodyBytes);
    List listRes = jsonDecode(decodeRes);

    return listRes;
  }

  // 画面を更新
  void notify() {
    notifyListeners();
  }
}
