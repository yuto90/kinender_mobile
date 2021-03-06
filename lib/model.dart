import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:collection';
import 'package:shared_preferences/shared_preferences.dart';

class Model {
  static String baseUrl = 'http://127.0.0.1/';

  // LoginAPIを呼び出す
  // method: POST
  static Future<String> callLoginApi(
    String email,
    String password,
  ) async {
    Uri endpoint = Uri.parse(baseUrl + 'api/auth/jwt/create/');
    Map<String, String> body = {
      'email': email,
      'password': password,
    };

    try {
      http.Response response = await http.post(
        endpoint,
        body: body,
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // 返却結果をUTF8にコンバート
        String decodeRes = utf8.decode(response.bodyBytes);
        return decodeRes;
      }
    } catch (e) {
      // http通信エラー
      return e.toString();
    }
  }

  // PostDateAPIを呼び出す
  // method: GET
  static Future<http.Response> callGetPostDateApi() async {
    Uri endpoint = Uri.parse(baseUrl + 'api/post_date/');

    // ローカルストレージにアクセスしてログイン中ユーザーのjwtトークンを取得
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwtToken = prefs.getString('accessToken') ?? '';

    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': jwtToken,
    };

    http.Response response = await http.get(
      endpoint,
      headers: headers,
    );
    return response;
  }

  // PostDateAPIを呼び出す
  // method: POST
  static Future<String> callPostPostDateApi(
    String inputDate,
    String inputTitle,
    String inputMemo,
    String uuid,
  ) async {
    Uri endpoint = Uri.parse(baseUrl + 'api/post_date/');

    // ローカルストレージにアクセスしてログイン中ユーザーのjwtトークンを取得
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwtToken = prefs.getString('accessToken') ?? '';

    Map<String, String> headers = {'Authorization': jwtToken};
    Map<String, String> body = {
      'date': inputDate,
      'title': inputTitle,
      'memo': inputMemo,
      'author_id': uuid,
    };

    try {
      http.Response response = await http.post(
        endpoint,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        return response.statusCode.toString();
      } else {
        // 返却結果をUTF8にコンバート
        String decodeRes = utf8.decode(response.bodyBytes);
        return decodeRes;
      }
    } catch (e) {
      return e.toString();
    }
  }

  // PostDateAPIを呼び出す
  // method: PATCH
  static Future<String> callUpdatePostDateApi(
    String eventId,
    String inputDate,
    String inputTitle,
    String inputMemo,
  ) async {
    Uri endpoint = Uri.parse(baseUrl + 'api/post_date/$eventId/');

    // ローカルストレージにアクセスしてログイン中ユーザーのjwtトークンを取得
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwtToken = prefs.getString('accessToken') ?? '';

    Map<String, String> headers = {'Authorization': jwtToken};
    Map<String, String> body = {
      'date': inputDate,
      'title': inputTitle,
      'memo': inputMemo,
    };

    try {
      http.Response response = await http.patch(
        endpoint,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        return response.statusCode.toString();
      } else {
        // 返却結果をUTF8にコンバート
        String decodeRes = utf8.decode(response.bodyBytes);
        return decodeRes;
      }
    } catch (e) {
      return e.toString();
    }
  }

  // PostDateAPIを呼び出す
  // method: DELETE
  static Future<String> callDeletePostDateApi(String eventId) async {
    Uri endpoint = Uri.parse(baseUrl + 'api/post_date/$eventId/');

    // ローカルストレージにアクセスしてログイン中ユーザーのjwtトークンを取得
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwtToken = prefs.getString('accessToken') ?? '';

    Map<String, String> headers = {'Authorization': jwtToken};

    try {
      http.Response response = await http.delete(
        endpoint,
        headers: headers,
      );

      if (response.statusCode == 200) {
        return response.statusCode.toString();
      } else {
        // 返却結果をUTF8にコンバート
        String decodeRes = utf8.decode(response.bodyBytes);
        return decodeRes;
      }
    } catch (e) {
      return e.toString();
    }
  }

  // MypageAPIを呼び出す
  // method: GET
  static Future callMypageApi() async {
    Uri endpoint = Uri.parse(baseUrl + 'api/mypage/');

    // ローカルストレージにアクセスしてログイン中ユーザーのjwtトークンを取得
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwtToken = prefs.getString('accessToken') ?? '';

    try {
      var response =
          await http.get(endpoint, headers: {'Authorization': jwtToken});
      // 返却結果をUTF8にコンバート
      String decodeRes = utf8.decode(response.bodyBytes);

      if (response.statusCode == 200) {
        return jsonDecode(decodeRes);
      } else {
        return ['error'];
      }
    } catch (e) {
      return e;
    }
  }

  // RegisterAPIを呼び出す
  // method: POST
  static Future<String> callRegisterApi(
    String name,
    String email,
    String password,
  ) async {
    Uri endpoint = Uri.parse(baseUrl + 'api/register/');
    Map<String, String> body = {
      'name': name,
      'email': email,
      'password': password,
    };

    try {
      http.Response response = await http.post(
        endpoint,
        body: body,
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // 返却結果をUTF8にコンバート
        String decodeRes = utf8.decode(response.bodyBytes);
        return decodeRes;
      }
    } catch (e) {
      // http通信エラー
      return e.toString();
    }
  }

  // TokenRefreshAPIを呼び出す
  // method: POST
  static Future<http.Response> callTokenRefreshApi() async {
    http.Response response;
    Uri endpoint = Uri.parse(baseUrl + 'api/auth/jwt/refresh/');

    // ローカルストレージにアクセスしてログイン中ユーザーのjwtトークンを取得
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String refreshToken = prefs.getString('refreshToken') ?? '';
    refreshToken = refreshToken.substring(4);

    Map<String, String> body = {
      "refresh": refreshToken,
    };

    response = await http.post(
      endpoint,
      body: body,
    );

    return response;
  }

  // TokenRefreshAPIを呼び出す
  // method: POST
  // トークン有効期限内かを判断。trueなら「200」, falseなら「401」を返す
  static Future<http.Response> callDjoserVerifyApi(String accessToken) async {
    http.Response response;
    Uri endpoint = Uri.parse(baseUrl + 'api/auth/jwt/verify/');

    // todo accessTokenを「JWT」ごと保存するのをやめる
    accessToken = accessToken.substring(4);

    Map<String, String> body = {
      "token": accessToken,
    };

    response = await http.post(
      endpoint,
      body: body,
    );

    return response;
  }
}
