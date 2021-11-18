import 'package:flutter/material.dart';
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
                child: Container(
                  color: Colors.blue,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
