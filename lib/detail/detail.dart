import 'package:flutter/material.dart';
import 'package:kinender_mobile/header/header.dart';
import 'package:provider/provider.dart';
import 'detail_model.dart';

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // providerからデータ受け取り
    Map post = context.watch<Map>();
    return ChangeNotifierProvider<DetailModel>(
      create: (_) => DetailModel(),
      child: Consumer<DetailModel>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: Header(isReturnButton: true),
            body: Column(
              children: [
                Center(
                  child: Text(post.toString()),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
