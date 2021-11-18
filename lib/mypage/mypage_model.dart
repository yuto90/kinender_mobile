import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model.dart';

class MypageModel extends ChangeNotifier {
  String userName = '名前';

  Future<String> getUserName() async {
    var userInfo = await Model.callMypageApi();
    return userInfo['name'];
  }
}
