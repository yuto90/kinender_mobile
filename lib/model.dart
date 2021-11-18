import 'package:http/http.dart' as http;
import 'dart:convert';

class Model {
  // PostDateAPIを呼び出す
  // method: GET
  static Future<List> callGetPostDateApi() async {
    Uri endpoint = Uri.parse('http://localhost:8000/api/post_date/');
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
  }

  // MypageAPIを呼び出す
  // method: GET
  static Future<dynamic> callMypageApi() async {
    Uri endpoint = Uri.parse('http://localhost:8000/api/mypage/');
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
  }
}