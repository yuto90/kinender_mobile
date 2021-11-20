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
          // ログイン状態を判別
          if (model.isAuth()) {
            return AuthPage();
          } else {
            //print(currentUser);
            return Home();
          }
        },
      ),
    );
  }
}
