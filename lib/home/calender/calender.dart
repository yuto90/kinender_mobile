import 'package:flutter/material.dart';
import 'package:kinender_mobile/detail/detail.dart';
import 'package:kinender_mobile/home/home.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../home_model.dart';

class Calender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeModel model = context.watch<HomeModel>();

    return SingleChildScrollView(
      child: Column(
        children: [
          TableCalendar(
            locale: 'ja_JP',
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2999, 12, 31),

            // カレンダーヘッダー
            //headerStyle: HeaderStyle(
            //formatButtonVisible: false,
            //titleCentered: true,
            //rightChevronIcon: Icon(
            //Icons.chevron_right,
            //size: 16,
            //color: Colors.grey,
            //),
            //leftChevronIcon: Icon(
            //Icons.chevron_left,
            //size: 16,
            //color: Colors.grey,
            //),
            //),

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
          Container(
            decoration: BoxDecoration(
              border: const Border(
                top: const BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
            ),
            child: FutureBuilder(
              future: model.createPostDateData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // 非同期処理未完了 = 通信中
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.error != null) {
                  // エラー
                  return Center(
                    child: Text('APIエラー'),
                  );
                }

                return ListView(
                  shrinkWrap: true,
                  children: model
                      .getEventForDay(model.selectedDay)
                      .map((event) => ListTile(
                            title: Text(event.toString()),
                            // タップして詳細画面へ遷移
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Detail(),
                                ),
                              );
                            },
                          ))
                      .toList(),
                );
              },
            ),
          ),
        ],
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
        color: Color(0xFF42b983),
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
