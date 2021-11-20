import 'package:flutter/material.dart';
import 'package:kinender_mobile/detail/detail.dart';
import 'package:kinender_mobile/header/header.dart';
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
                child: Container(
                  child: FutureBuilder(
                    future: model.getUserName(),
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
                        child: Text(snapshot.data.toString()),
                      );
                    },
                  ),
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
                                      decoration: BoxDecoration(
                                        border: const Border(
                                          bottom: const BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: ListTile(
                                        title: Text(event["title"].toString()),
                                        // タップして詳細画面へ遷移
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Detail(),
                                            ),
                                          );
                                        },
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
