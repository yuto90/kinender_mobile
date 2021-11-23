import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model.dart';

class DetailModel extends ChangeNotifier {
  // APIに埋めるデータ
  DateTime? inputDate;
  String? formatInputDate;

  String? eventId;

  TextEditingController titleController = TextEditingController();
  TextEditingController memoController = TextEditingController();

  void initDate(Map eventData) {
    // 画面更新時にproviderからのデータを再代入させない
    if (inputDate == null) {
      eventId = eventData['id'];
      inputDate = DateTime.parse(eventData['date']);
      titleController.text = eventData['title'];
      memoController.text = eventData['memo'];
    }
  }

  // 日付を選択して設定日付を上書き
  Future selectDate(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: inputDate!,
      firstDate: DateTime(1900),
      lastDate: DateTime.now().add(
        Duration(days: 360),
      ),
    );
    inputDate = picked!;
    notifyListeners();
  }

  // DateTime型をyyyy-MM-dd形式のString型にフォーマットする
  String formatDate() {
    DateFormat outputFormat = DateFormat('yyyy-MM-dd');
    formatInputDate = outputFormat.format(inputDate!);
    return formatInputDate!;
  }

  // 投稿を更新する
  Future<String> updateEvent() async {
    String inputTitle = titleController.text;
    String inputMemo = memoController.text;

    // PostDateAPI(PATCH)を呼び出し
    String res = await Model.callUpdatePostDateApi(
      eventId!,
      formatInputDate!,
      inputTitle,
      inputMemo,
    );
    return res;
  }

  // 投稿を削除する
  Future<String> deleteEvent() async {
    // PostDateAPI(PATCH)を呼び出し
    String res = await Model.callDeletePostDateApi(eventId!);
    return res;
  }
}
