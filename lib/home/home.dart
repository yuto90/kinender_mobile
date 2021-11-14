import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:provider/provider.dart';
import '../header/header.dart';
import 'home_model.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeModel>(
      create: (_) => HomeModel(),
      child: Consumer<HomeModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: Header(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: CalendarCarousel<Event>(
                      onDayPressed: model.onDayPressed,
                      weekendTextStyle: TextStyle(color: Colors.red),
                      thisMonthDayBorderColor: Colors.grey,
                      weekFormat: false,
                      height: 420.0,
                      daysHaveCircularBorder: false,
                      customGridViewPhysics: NeverScrollableScrollPhysics(),
                      markedDateShowIcon: true,
                      markedDateIconMaxShown: 2,
                      todayTextStyle: TextStyle(
                        color: Colors.blue,
                      ),
                      markedDateIconBuilder: (event) {
                        return event.icon;
                      },
                      todayBorderColor: Colors.green,
                      markedDateMoreShowTotal: false,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: model.callMypageApi,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
