import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:http/http.dart' as http;
import 'package:kinender_mobile/mypage/mypage.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:table_calendar/table_calendar.dart';
import '../model.dart';
import 'calendar/calendar.dart';

class HomeModel extends ChangeNotifier {
  Map<DateTime, List> postDate = {};

  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.month;

  // 画面切り替え用のページ
  Map<int, Widget> pages = {
    0: Provider<dynamic>.value(
      value: HomeModel,
      child: Container(
        child: Calendar(),
      ),
    ),
    1: Mypage(),
  };

  // 表示中のページ。デフォルトは0
  int currentIndex = 0;

  // initState的なやつ
  HomeModel() {
    initValue();
  }

  void initValue() {
    print('init');
  }

  // フッターがタップされた時に色を変える
  void changeSelectedItemColor(int index) {
    if (currentIndex != index) {
      currentIndex = index;
      notifyListeners();
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
    )..addAll(postDate);

    return _events[day] ?? [];
  }

  // PostDateAPIの返却値を元にイベント情報をMapで生成
  Future createPostDateData() async {
    DateTime parseDate;

    // API返却値が格納されていない場合のみ呼び出し
    if (postDate.isEmpty) {
      // PostDateAPIを呼び出し
      List res = await Model.callGetPostDateApi();

      // Map<DateTime, List>のデータ型に変換
      res.forEach((event) {
        // ['date']をDatetimeに変換
        parseDate = DateTime.parse(event['date']);

        //同じ日時のkeyが存在したらvalueに['title']を追加する
        if (postDate.containsKey(parseDate)) {
          //postDate[parseDate]!.add([event['id'], event['title']]);
          postDate[parseDate]!.add({
            'id': event['id'],
            'date': event['date'],
            'title': event['title'],
            'memo': event['memo'],
          });
        } else {
          postDate[parseDate] = [
            {
              'id': event['id'],
              'date': event['date'],
              'title': event['title'],
              'memo': event['memo'],
            }
          ];
        }
      });
      // todo 何かしらデータが格納されていないと無限ループしてしまうので苦し紛れ
      postDate[DateTime(2999, 12, 31)] = ['init'];
      notifyListeners();
    }
  }

  // 登録した新しいイベントをカレンダーに反映させる
  void addNewEvent(event) {
    if (event != null) {
      DateTime newEventDate = event[0];
      String newEventTitle = event[1];
      // 同じ日付にイベントが存在したらその日付の配列にイベントを追加
      if (postDate.containsKey(newEventDate)) {
        postDate[newEventDate]!.add(newEventTitle);
      } else {
        Map<DateTime, List> newEvent = {
          newEventDate: [newEventTitle]
        };

        postDate.addAll(newEvent);
      }

      notifyListeners();
    }
  }
}
