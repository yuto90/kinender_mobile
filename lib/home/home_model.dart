import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeModel extends ChangeNotifier {
  String mypage = '';

  void callMypageApi() async {
    Uri endpoint = Uri.parse('http://localhost:8000/api/mypage/');
    var response = await http.get(endpoint, headers: {'Authorization': ''});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    mypage = response.body;
    notifyListeners();

    // print(await http.read(Uri.parse('http://localhost:8000/api/mypage/')));
  }
}
