import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/auth_page.dart';
import 'auth/auth_page_model.dart';
import 'home/home.dart';

class UserCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthPageModel>(
      create: (_) => AuthPageModel(),
      child: Consumer<AuthPageModel>(
        builder: (context, model, child) {
          // jwtトークンが保存されているかを確認して認証中であればHome画面へ、されていなければ認証画面へ飛ばす
          return FutureBuilder(
            future: model.isSaveToken(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // 非同期処理未完了 = 通信中
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.error != null) {
                // エラー
                return Center(
                  child: Text('エラー'),
                );
              }

              return snapshot.data ? Home() : AuthPage();
            },
          );
        },
      ),
    );
  }
}
