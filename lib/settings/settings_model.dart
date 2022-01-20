import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model.dart';

class SettingsModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  Future<Map> getUserInfo() async {
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
