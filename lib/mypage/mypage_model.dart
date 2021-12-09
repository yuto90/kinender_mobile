import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model.dart';

class MypageModel extends ChangeNotifier {
  String userName = '名前';

  Future<String> getUserName() async {
    Map userInfo = await Model.callMypageApi();
    return userInfo['name'];
  }

  // PostDateAPIの返却値をそのまま返すだけ
  Future<List> getAllEvent() async {
    // PostDateAPIを呼び出し
    List res = await Model.callGetPostDateApi();
    return res;
  }

  // ログアウト処理
  void logout() async {
    // ローカルストレージに保存されているjwtトークンを削除
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('accessToken');
    prefs.remove('refreshToken');
  }

  // 画面を更新
  void notify() {
    notifyListeners();
  }
}
