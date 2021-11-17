import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:table_calendar/table_calendar.dart';

class HomeModel extends ChangeNotifier {
  String mypage = '';
  Map<DateTime, List> postDate = {};

  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.month;

  // MypageAPIを呼び出す
  // method: GET
  void callMypageApi() async {
    Uri endpoint = Uri.parse('http://localhost:8000/api/mypage/');
    var response = await http.get(endpoint, headers: {'Authorization': ''});
    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');
    mypage = response.body;
    notifyListeners();

    // print(await http.read(Uri.parse('http://localhost:8000/api/mypage/')));
  }

  // PostDateAPIを呼び出す
  // method: GET
  Future<List> callGetPostDateApi() async {
    Uri endpoint = Uri.parse('http://localhost:8000/api/post_date/');
    http.Response response = await http.get(endpoint, headers: {
      'Authorization':
          'JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ1c2VybmFtZSI6InNvbGlkdXNnYWtvNDA4N0BnbWFpbC5jb20iLCJleHAiOjE2MzYyMDM2NTEsImVtYWlsIjoic29saWR1c2dha280MDg3QGdtYWlsLmNvbSJ9.Kgy7Imy7nWbng5VkAKgHBb4BNC5hze-F4sqysMYugN0'
    });

    // 返却結果をUTF8にコンバート
    String decodeRes = utf8.decode(response.bodyBytes);

    //print('Response status: ${response.statusCode}');
    //print('Response body: ${decodeRes}');
    if (response.statusCode == 200) {
      // stringで返されているレスポンスをJsonに変換
      return jsonDecode(decodeRes);
    } else {
      return ['error'];
    }
  }

  // カレンダーのフォーマットを切り替える
  void changeFormat(format) {
    if (calendarFormat != format) {
      calendarFormat = format;
      notifyListeners();
    }
  }

  // 選択した日付に印を付ける
  void markTapDay(_selectedDay, _focusedDay) {
    if (!isSameDay(selectedDay, _selectedDay)) {
      selectedDay = _selectedDay;
      focusedDay = _focusedDay;
      notifyListeners();
      getEventForDay(_selectedDay);
    }
  }

  // DateTime型から20210930の8桁のint型へ変換
  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  // イベントを取得
  List getEventForDay(DateTime day) {
    final _events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
      //)..addAll(postDateMock);
    )..addAll(postDate);

    return _events[day] ?? [];
  }

  // PostDateAPIの返却値を元にイベント情報をMapで生成
  Future createPostDateData() async {
    DateTime parseDate;

    // API返却値が格納されていない場合のみ呼び出し
    if (postDate.isEmpty) {
      // PostDateAPIを呼び出し
      List res = await callGetPostDateApi();

      // Map<DateTime, List>のデータ型に変換
      res.forEach((event) {
        print(event['title']);
        print(DateTime.parse(event['date']));

        // ['date']をDatetimeに変換
        parseDate = DateTime.parse(event['date']);

        //同じ日時のkeyが存在したらvalueに['title']を追加する
        if (postDate.containsKey(parseDate)) {
          postDate[parseDate]!.add(event['title']);
        } else {
          postDate[parseDate] = [event['title']];
        }
        notifyListeners();
      });
    }
  }
}
