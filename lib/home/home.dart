import 'package:flutter/material.dart';
import 'package:kinender_mobile/footer/footer.dart';
import 'package:kinender_mobile/home/calender/calender.dart';
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
            appBar: Header(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Calender(),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Footer(),
            floatingActionButton: FloatingActionButton(
              onPressed: model.callGetPostDateApi,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
