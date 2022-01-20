import 'package:flutter/material.dart';
import 'package:kinender_mobile/header/header.dart';
import 'package:provider/provider.dart';
import '../../user_check.dart';
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
              child: FutureBuilder(
                future: model.getUserInfo(),
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
                      child: Text('APIエラー'),
                    );
                  }

                  return Container(
                    child: Column(
                      children: [
                        ListTile(
                          subtitle: Text(
                            snapshot.data['name'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          title: Text(
                            'ユーザー名',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: ElevatedButton(
                            child: Text(
                              '変更',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              elevation: 0,
                            ),
                            onPressed: () {
                              print('変更');
                            },
                          ),
                        ),
                        ListTile(
                          subtitle: Text(
                            snapshot.data['email'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          title: Text(
                            'メールアドレス',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: ElevatedButton(
                            child: Text(
                              '変更',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              elevation: 0,
                            ),
                            onPressed: () {
                              print('変更');
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                            child: Text(
                              'ログアウト',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              elevation: 0,
                            ),
                            // ログアウトさせてUserCheck画面に戻す
                            onPressed: () {
                              model.logout();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserCheck(),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),

              //child: Column(
              //children: [
              //TextField(
              //controller: model.nameController,
              //decoration: InputDecoration(
              //hintText: 'ユーザー名',
              //),
              //),
              //TextField(
              //controller: model.passController,
              //decoration: InputDecoration(
              //hintText: 'パスワード',
              //),
              //),
              //ElevatedButton(
              //onPressed: () {
              //Navigator.pop(context);
              //},
              //child: Text('更新'),
              //),
              //],
              //),
            ),
          );
        },
      ),
    );
  }
}
