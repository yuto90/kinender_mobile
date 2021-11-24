import 'package:flutter/material.dart';
import 'package:kinender_mobile/header/header.dart';
import 'package:provider/provider.dart';
import 'detail_model.dart';

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailModel>(
      create: (_) => DetailModel(),
      child: Consumer<DetailModel>(
        builder: (context, model, child) {
          // providerからデータ受け取り
          model.initDate(context.watch<Map>());

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: Header(
              isReturnButton: true,
              title: '詳細',
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
                      Future<String> res = model.updateEvent();
                      Navigator.pop(context, res);
                    },
                    child: Text('登録'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Future<String> res = model.deleteEvent();
                      Navigator.pop(context, res);
                    },
                    child: Text('削除'),
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
