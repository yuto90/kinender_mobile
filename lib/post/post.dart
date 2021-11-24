import 'package:flutter/material.dart';
import 'package:kinender_mobile/header/header.dart';
import 'package:provider/provider.dart';
import 'post_model.dart';

class Post extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostModel>(
      create: (_) => PostModel(),
      child: Consumer<PostModel>(
        builder: (context, model, child) {
          // providerからデータ受け取り
          model.initDate(context.watch<DateTime>());

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: Header(
              isReturnButton: true,
              title: '新規追加',
            ),
            body: Container(
              margin: EdgeInsets.all(30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Text(model.formatDate()),
                            ElevatedButton(
                              onPressed: () {
                                model.selectDate(context);
                              },
                              child: Icon(Icons.calendar_today),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  TextField(
                    controller: model.titleController,
                    decoration: InputDecoration(
                      hintText: 'どんな日？',
                    ),
                  ),
                  TextField(
                    controller: model.memoController,
                    decoration: InputDecoration(
                      hintText: 'メモ',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // calendar画面に登録したイベントの情報を返却
                      Future<String> registeredEvent = model.postEvent();
                      Navigator.pop(context, registeredEvent);
                    },
                    child: Text('登録'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
