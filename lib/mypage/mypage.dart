import 'package:flutter/material.dart';
import 'package:kinender_mobile/detail/detail.dart';
import 'package:kinender_mobile/header/header.dart';
import 'package:kinender_mobile/user_check.dart';
import 'package:provider/provider.dart';
import 'mypage_model.dart';

class Mypage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MypageModel>(
      create: (_) => MypageModel(),
      child: Consumer<MypageModel>(
        builder: (context, model, child) {
          return Column(
            children: [
              Expanded(
                flex: 1,
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
                                      builder: (context) => UserCheck()),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text('▼記念日一覧'),
                      Container(
                        decoration: BoxDecoration(
                          border: const Border(
                            top: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                        ),
                        child: FutureBuilder(
                          future: model.getAllEvent(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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

                            return ListView(
                              shrinkWrap: true,
                              children: snapshot.data
                                  .map<Widget>(
                                    (event) => Container(
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: const Border(
                                          bottom: const BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Material(
                                        elevation: 5,
                                        child: ListTile(
                                          leading: FlutterLogo(size: 56.0),
                                          title:
                                              Text(event["title"].toString()),
                                          subtitle:
                                              Text(event["date"].toString()),
                                          // タップして詳細画面へ遷移
                                          onTap: () async {
                                            var updatedEvent =
                                                await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Provider<Map>.value(
                                                  value: event,
                                                  child: Detail(),
                                                ),
                                              ),
                                            );

                                            model.notify();
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
