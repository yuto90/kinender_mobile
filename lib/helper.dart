// helper関数を置くファイル
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';

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

  // トークンの有効期限をチェックする
  static Future<String> checkToken() async {
    // ローカルストレージにアクセスしてログイン中ユーザーのjwtトークンを取得
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken') ?? '';

    // トークンの有効期限を確認
    http.Response res = await Model.callDjoserVerifyApi(accessToken);
    // トークンが期限切れだったらリフレッシュ
    if (res.statusCode != 200) {
      http.Response newToken = await Model.callTokenRefreshApi();
      if (newToken.statusCode != 200) {
        // todo リフレッシュトークンも期限切れだったらの処理
        return 'refreshToken Expired';
      } else {
        // リフレッシュしたトークンをローカルにセットする
        await Helper.setNewToken(newToken);
        return 'token refresh ok';
      }
    } else {
      return 'accessToken ok';
    }
  }
}
