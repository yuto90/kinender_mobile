import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

class HomeModel extends ChangeNotifier {
  String mypage = '';

  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.month;

  // MypageAPIを呼び出す
  void callMypageApi() async {
    Uri endpoint = Uri.parse('http://localhost:8000/api/mypage/');
    var response = await http.get(endpoint, headers: {'Authorization': ''});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    mypage = response.body;
    notifyListeners();

    // print(await http.read(Uri.parse('http://localhost:8000/api/mypage/')));
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

  // イベントのテストデータ
  Map<DateTime, List> eventsList = {
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
    )..addAll(eventsList);

    return _events[day] ?? [];
  }
}
