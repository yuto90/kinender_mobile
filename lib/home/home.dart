import 'package:flutter/material.dart';
import 'package:kinender_mobile/home/footer/footer.dart';
import 'package:kinender_mobile/home/calendar/calendar.dart';
import 'package:kinender_mobile/post/post.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../header/header.dart';
import 'home_model.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeModel>(
      create: (_) => HomeModel(),
      child: Consumer<HomeModel>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            //appBar: Header(isReturnButton: false, title: 'カレンダー'),
            appBar: model.headers[model.currentIndex],
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: model.pages[model.currentIndex],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: MultiProvider(
              providers: [
                Provider<int>.value(value: model.currentIndex),
                Provider<Function>.value(value: model.changeSelectedItemColor),
              ],
              child: Footer(),
            ),
            floatingActionButton: model.currentIndex == 1
                ? FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () async {
                      // 戻るボタンを押されたらnull, 登録を押したらListを返却
                      var registeredEvent = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MultiProvider(
                            providers: [
                              Provider<DateTime>.value(
                                  value: model.selectedDay),
                            ],
                            child: Post(),
                          ),
                        ),
                      );
                      model.updateEvent(registeredEvent);
                    },
                  )
                : null,
          );
        },
      ),
    );
  }
}
