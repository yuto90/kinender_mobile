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
            appBar: Header(),
            body: Container(
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
