import 'dart:collection';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Model {
  // LoginAPIを呼び出す
  // method: POST
  static Future<String> callLoginApi(
    String email,
    String password,
  ) async {
    Uri endpoint = Uri.parse('http://localhost:8000/login/');
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
  static Future<List> callGetPostDateApi() async {
    Uri endpoint = Uri.parse('http://localhost:8000/api/post_date/');
    try {
      http.Response response = await http.get(endpoint, headers: {
        'Authorization':
            'JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ1c2VybmFtZSI6InNvbGlkdXNnYWtvNDA4N0BnbWFpbC5jb20iLCJleHAiOjE2MzYyMDM2NTEsImVtYWlsIjoic29saWR1c2dha280MDg3QGdtYWlsLmNvbSJ9.Kgy7Imy7nWbng5VkAKgHBb4BNC5hze-F4sqysMYugN0'
      });
      // 返却結果をUTF8にコンバート
      String decodeRes = utf8.decode(response.bodyBytes);

      //print('Response status: ${response.statusCode}');
      //print('Response body: ${decodeRes}');
      if (response.statusCode == 200) {
        // stringで返されているレスポンスをJsonに変換
        return jsonDecode(decodeRes);
      } else {
        return ['error'];
      }
    } catch (e) {
      return [e];
    }
  }

  // PostDateAPIを呼び出す
  // method: POST
  static Future<String> callPostPostDateApi(
    String inputDate,
    String inputTitle,
    String inputMemo,
    String uuid,
  ) async {
    Uri endpoint = Uri.parse('http://localhost:8000/api/post_date/');
    Map<String, String> headers = {
      'Authorization':
          'JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ1c2VybmFtZSI6InNvbGlkdXNnYWtvNDA4N0BnbWFpbC5jb20iLCJleHAiOjE2MzYyMDM2NTEsImVtYWlsIjoic29saWR1c2dha280MDg3QGdtYWlsLmNvbSJ9.Kgy7Imy7nWbng5VkAKgHBb4BNC5hze-F4sqysMYugN0'
    };
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

  // MypageAPIを呼び出す
  // method: GET
  static Future callMypageApi() async {
    Uri endpoint = Uri.parse('http://localhost:8000/api/mypage/');
    try {
      var response = await http.get(endpoint, headers: {
        'Authorization':
            'JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ1c2VybmFtZSI6InNvbGlkdXNnYWtvNDA4N0BnbWFpbC5jb20iLCJleHAiOjE2MzYyMDM2NTEsImVtYWlsIjoic29saWR1c2dha280MDg3QGdtYWlsLmNvbSJ9.Kgy7Imy7nWbng5VkAKgHBb4BNC5hze-F4sqysMYugN0'
      });
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
}
