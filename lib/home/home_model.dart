import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:http/http.dart' as http;
import 'package:kinender_mobile/header/header.dart';
import 'package:kinender_mobile/mypage/mypage.dart';
import 'package:kinender_mobile/settings/settings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:table_calendar/table_calendar.dart';
import '../model.dart';
import 'calendar/calendar.dart';
import 'package:kinender_mobile/helper.dart';

class HomeModel extends ChangeNotifier {
  Map<DateTime, List> postDate = {};

  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.month;

  // 画面切り替え用のページ
  Map<int, Widget> pages = {
    0: Settings(),
    1: Provider<dynamic>.value(
      value: HomeModel,
      child: Container(
        child: Calendar(),
      ),
    ),
    2: Mypage(),
  };

  // 画面毎のヘッダー
  Map<int, PreferredSizeWidget?> headers = {
    0: Header(isReturnButton: false, title: '設定'),
    1: Header(isReturnButton: false, title: 'カレンダー'),
    2: Header(isReturnButton: false, title: 'マイページ'),
  };

  // 表示中のページ。デフォルトは1
  int currentIndex = 1;

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

  // 画面読み込み時にカレンダー表示用データセットの初期データを生成する
  Future<List> initCalendarData() async {
    // API返却値が格納されていない場合のみ呼び出し
    if (postDate.isEmpty) {
      await createCalendarData();
      notifyListeners();
    }

    return [selectedDay.day, selectedDay.weekday];
  }

  // 更新したイベントをカレンダーに反映させる
  void updateEvent(events) async {
    if (events != null) {
      // 更新前のデータセットを初期化
      postDate = {};
      await createCalendarData();
      notifyListeners();
    }
  }

  // PostDateAPIからの返却値を元にカレンダー表示用のデータセットを生成する
  Future createCalendarData() async {
    DateTime parseDate;
    http.Response eventData;
    http.Response newToken;

    // API呼び出し前にトークンをチェック
    String res = await Helper.checkToken();

    if (res != 'refreshToken Expired') {
      // PostDateAPIを呼び出し
      eventData = await Model.callGetPostDateApi();

      // 返却結果をUTF8にコンバート
      String decodeRes = utf8.decode(eventData.bodyBytes);

      List listRes = jsonDecode(decodeRes);

      // Map<DateTime, List>のデータ型に変換
      listRes.forEach((event) {
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
    }
  }

  // カウントダウンの計算
  String calcCountDown() {
    final Duration difference = DateTime.now().difference(selectedDay);
    final sec = difference.inSeconds;
    final now = DateTime.now();

    if (sec >= 60 * 60 * 24) {
      return '${difference.inDays.toString()}日前です！';
    } else if (selectedDay.day == now.day) {
      return '今日が記念日です！';
    } else {
      int futureDiff = (difference.inDays - 1) * -1;
      return '${futureDiff.toString()}日後です！';
    }
  }
}
