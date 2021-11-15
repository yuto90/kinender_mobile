import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

class HomeModel extends ChangeNotifier {
  String mypage = '';

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
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
    }
  }
}
