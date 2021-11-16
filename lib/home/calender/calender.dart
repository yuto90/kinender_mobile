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
          return Column(
            children: [
              TableCalendar(
                locale: 'ja_JP',
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2999, 12, 31),
                focusedDay: model.focusedDay,
                eventLoader: model.getEventForDay,
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
                onPageChanged: (_focusedDay) {
                  model.focusedDay = _focusedDay;
                },
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    if (events.isNotEmpty) {
                      return buildEventsMarker(date, events);
                    }
                  },
                ),
              ),
              ListView(
                shrinkWrap: true,
                children: model
                    .getEventForDay(model.selectedDay)
                    .map((event) => ListTile(
                          title: Text(event.toString()),
                        ))
                    .toList(),
              )
            ],
          );
        },
      ),
    );
  }
}

Widget buildEventsMarker(DateTime date, List events) {
  return Positioned(
    right: 5,
    bottom: 5,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red[300],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    ),
  );
}
