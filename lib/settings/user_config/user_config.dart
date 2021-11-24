import 'package:flutter/material.dart';
import 'package:kinender_mobile/header/header.dart';
import 'package:provider/provider.dart';
import '../settings_model.dart';

class UserConfig extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsModel>(
      create: (_) => SettingsModel(),
      child: Consumer<SettingsModel>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: Header(
              isReturnButton: true,
              title: 'ユーザー情報編集',
            ),
            body: Container(
              margin: EdgeInsets.all(30),
              child: Column(
                children: [
                  TextField(
                    controller: model.nameController,
                    decoration: InputDecoration(
                      hintText: 'ユーザー名',
                    ),
                  ),
                  TextField(
                    controller: model.passController,
                    decoration: InputDecoration(
                      hintText: 'パスワード',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('更新'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
