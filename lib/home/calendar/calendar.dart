import 'package:flutter/material.dart';
import 'package:kinender_mobile/detail/detail.dart';
import 'package:kinender_mobile/home/home.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../home_model.dart';

class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeModel model = context.watch<HomeModel>();

    return SingleChildScrollView(
      child: Column(
        children: [
          TableCalendar(
            locale: 'ja_JP',
            firstDay: DateTime.utc(1975, 1, 1),
            lastDay: DateTime.utc(2999, 12, 31),
            // カレンダーヘッダー
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              rightChevronIcon: Icon(
                Icons.chevron_right,
                size: 20,
                color: Color(0xFF42b983),
              ),
              leftChevronIcon: Icon(
                Icons.chevron_left,
                size: 20,
                color: Color(0xFF42b983),
              ),
            ),
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
            child: FutureBuilder(
              future: model.initCalendarData(),
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

                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: const Border(
                          top: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                          bottom: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 50,
                          //color: Colors.red,
                          child: Center(
                            child: Text(
                              snapshot.data[0].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Color(0xFF42b983),
                              ),
                            ),
                          ),
                        ),
                        title: Text(model.calcCountDown()),
                      ),
                    ),
                    ListView(
                      shrinkWrap: true,
                      children: model
                          .getEventForDay(model.selectedDay)
                          .map(
                            (event) => Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: const Border(
                                  bottom: const BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Material(
                                elevation: 5,
                                child: ListTile(
                                  leading: FlutterLogo(size: 56.0),
                                  title: Text(event["title"].toString()),
                                  subtitle: Text(event["date"].toString()),
                                  // タップして詳細画面へ遷移
                                  onTap: () async {
                                    var updatedEvent = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Provider<Map>.value(
                                          value: event,
                                          child: Detail(),
                                        ),
                                      ),
                                    );

                                    model.updateEvent(updatedEvent);
                                  },
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
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
