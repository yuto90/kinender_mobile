// helper関数を置くファイル
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  // TokenRefreshAPIから戻された新しいトークンをローカルストレージに保存する
  static Future setNewToken(http.Response token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String convertNewToken = utf8.decode(token.bodyBytes);
    dynamic newToken = jsonDecode(convertNewToken);

    String newAccessToken = newToken['access'];
    String newRefreshToken = newToken['refresh'];
    newAccessToken = 'JWT ' + newAccessToken;
    newRefreshToken = 'JWT ' + newRefreshToken;

    prefs.setString('accessToken', newAccessToken);
    prefs.setString('refreshToken', newRefreshToken);
  }
}
