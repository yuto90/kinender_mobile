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

  //イベントのテストデータ
  Map<DateTime, List> postDateMock = {
    DateTime.now().subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
    DateTime.now(): ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
    DateTime.now().add(Duration(days: 1)): [
      'Event A8',
      'Event B8',
      'Event C8',
      'Event D8'
    ],
    DateTime.now().add(Duration(days: 3)):
        Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
    DateTime.now().add(Duration(days: 7)): [
      'Event A10',
      'Event B10',
      'Event C10'
    ],
    DateTime.now().add(Duration(days: 11)): ['Event A11', 'Event B11'],
    DateTime.now().add(Duration(days: 17)): [
      'Event A12',
      'Event B12',
      'Event C12',
      'Event D12'
    ],
    DateTime.now().add(Duration(days: 22)): ['Event A13', 'Event B13'],
    DateTime.now().add(Duration(days: 26)): [
      'Event A14',
      'Event B14',
      'Event C14'
    ],
  };

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
      });
    }
  }
}
