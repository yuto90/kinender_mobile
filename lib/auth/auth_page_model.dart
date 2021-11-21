import 'package:flutter/material.dart';
import 'package:kinender_mobile/home/home.dart';

import '../model.dart';

class AuthPageModel extends ChangeNotifier {
  String? name;
  String? email;
  String? password;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // 認証済みかを返却する
  bool isAuth() {
    return true;
  }

  // ログイン処理
  Future<String> trySignIn(context) async {
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

  //! 登録処理
  Future signUp() async {}
}