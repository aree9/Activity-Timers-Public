import 'package:activity_timers/bloc/timer_bloc.dart';
import 'package:activity_timers/database/db_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:activity_timers/events/timer_events.dart';
import 'package:activity_timers/model/ActivityTimer.dart';
import 'package:flutter/material.dart';

import 'timerScreen.dart';

class NewTimer extends StatefulWidget {
  @override
  _NewTimerState createState() => _NewTimerState();
}

class _NewTimerState extends State<NewTimer> {
  final textController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Timer'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Timer Name',
              ),
            ),
            RaisedButton(
              onPressed: () {
                ActivityTimer timer = ActivityTimer(
                  title: textController.text,
                  duration: Duration(milliseconds: 0),
                );

                DatabaseProvider.db.insert(timer).then(
                      (storedTimer) => BlocProvider.of<TimerBloc>(context).add(
                        AddTimer(storedTimer),
                      ),
                    );

                Navigator.pop(context);

                /*Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TimerScreen(timer: timer),
                  ),
                );*/
              },
              child: Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
