import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../home_model.dart';

class Calender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeModel>(
      create: (_) => HomeModel(),
      child: Consumer<HomeModel>(
        builder: (context, model, child) {
          return TableCalendar(
            locale: 'ja_JP',
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2999, 12, 31),
            focusedDay: model.focusedDay,
            calendarFormat: model.calendarFormat,
            // カレンダーのフォーマット変更
            onFormatChanged: (format) {
              model.changeFormat(format);
            },
            // どの日が選択されているか判断
            selectedDayPredicate: (day) {
              // 比較されたDateTimeオブジェクトの時間部分を無視する
              return isSameDay(model.selectedDay, day);
            },
            // タップした日付に印が付く
            onDaySelected: (selectedDay, focusedDay) {
              model.markTapDay(selectedDay, focusedDay);
            },
          );
        },
      ),
    );
  }
}
