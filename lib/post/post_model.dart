import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../helper.dart';
import '../model.dart';

class PostModel extends ChangeNotifier {
  // APIに埋める日付
  DateTime? inputDate;
  String? formatInputDate;

  TextEditingController titleController = TextEditingController();
  TextEditingController memoController = TextEditingController();

  void initDate(DateTime defaltDate) {
    // 画面更新時にproviderからのデータを再代入させない
    if (inputDate == null) {
      inputDate = defaltDate;
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

  // 入力内容をDjangoに登録する
  Future<String> postEvent() async {
    String inputTitle = titleController.text;
    String inputMemo = memoController.text;

    // API呼び出し前にトークンをチェック
    String res = await Helper.checkToken();

    if (res != 'refreshToken Expired') {
      Map authUserInfo = await Model.callMypageApi();
      String uuid = authUserInfo['id'];

      // PostDateAPI(POST)を呼び出し
      var res = await Model.callPostPostDateApi(
        formatInputDate!,
        inputTitle,
        inputMemo,
        uuid,
      );

      return res;
    } else {
      return '';
    }
  }
}
