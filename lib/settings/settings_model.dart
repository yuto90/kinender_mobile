import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../helper.dart';
import '../model.dart';

class SettingsModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  Future getUserInfo() async {
    // API呼び出し前にトークンをチェック
    bool res = await Helper.checkToken();

    Map userInfo = await Model.callMypageApi();
    return userInfo;
  }

  // ログアウト処理
  void logout() async {
    // ローカルストレージに保存されているjwtトークンを削除
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('accessToken');
    prefs.remove('refreshToken');
  }
}
