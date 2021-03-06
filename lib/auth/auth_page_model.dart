import 'package:flutter/material.dart';
import 'package:kinender_mobile/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model.dart';

class AuthPageModel extends ChangeNotifier {
  String? name;
  String? email;
  String? password;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // 認証済みかを返却する
  Future<bool> isSaveToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String res = prefs.getString('accessToken') ?? '';

    if (res != '') {
      return true;
    } else {
      return false;
    }
  }

  // ログイン処理
  Future<String> trySignIn() async {
    email = emailController.text;
    password = passwordController.text;

    String validateRes = formValidate('signin');
    if (validateRes == 'ok') {
      String res = await Model.callLoginApi(email!, password!);
      print(res);
      return res;
    } else {
      return validateRes;
    }
  }

  // 登録処理
  Future<String> trySignUp() async {
    name = nameController.text;
    email = emailController.text;
    password = passwordController.text;

    String validateRes = formValidate('signup');
    if (validateRes == 'ok') {
      String res = await Model.callRegisterApi(name!, email!, password!);
      print(res);
      return res;
    } else {
      return validateRes;
    }
  }

  String formValidate(mode) {
    String errorWord = '';

    if (mode == 'signup' && name!.isEmpty) {
      errorWord = errorWord += '・ユーザー名を入力してください\n';
    }
    if (email!.isEmpty) {
      errorWord = errorWord += '・メールアドレスを入力してください\n';
    }
    if (password!.isEmpty) {
      errorWord = errorWord += '・パスワードを入力してください\n';
    }

    if (errorWord != '') {
      return errorWord;
    } else {
      return 'ok';
    }
  }

  // 返却されたaccessトークンとrefreshトークンをローカルストレージに保存
  Future<void> saveJwtToken(String stringJsonToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    dynamic jsonToken = jsonDecode(stringJsonToken);
    String accessToken = jsonToken['access'];
    String refreshToken = jsonToken['refresh'];
    accessToken = 'JWT ' + accessToken;
    refreshToken = 'JWT ' + refreshToken;

    prefs.setString('accessToken', accessToken);
    prefs.setString('refreshToken', refreshToken);
  }
}
