import 'package:activity_timers/model/ActivityTimer.dart';
import 'package:flutter/material.dart';
import 'package:activity_timers/database/db_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:activity_timers/bloc/timer_bloc.dart';

import 'package:activity_timers/events/timer_events.dart';
import 'dart:async';

const kUiNumber = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 64,
  color: Colors.white,
);
const kUiText = TextStyle(
  color: Colors.white,
);

class TimerScreen extends StatefulWidget {
  final ActivityTimer timer;
  final int timerIndex;

  TimerScreen({this.timer, this.timerIndex});

  @override
  State<StatefulWidget> createState() {
    return _TimerScreenState();
  }
}

class _TimerScreenState extends State<TimerScreen> {
  String title;
  String duration;
  Duration initialTime;

  @override
  void initState() {
    if (widget.timer != null) {
      title = widget.timer.title;
      //duration = widget.timer.duration;
      initialTime = widget.timer.duration;
    }
    super.initState();
  }

  @override
  void deactivate() {
    ActivityTimer timerToUpdate =
        ActivityTimer(title: widget.timer.title, duration: displayTime());

    DatabaseProvider.db.update(widget.timer).then(
          (storedTimer) => BlocProvider.of<TimerBloc>(context).add(
            UpdateTimer(widget.timerIndex, timerToUpdate),
          ),
        );

    print('Timer Updated to' + widget.timer.duration.toString());

    super.deactivate();
  }

  @override
  void dispose() {
    updateScreen.cancel();
    super.dispose();
  }

  void fabPressed() {
    print('FAB Pressed!');
    if (stopwatch.isRunning == false) {
      toggleFAB(true);
      setState(() {});
      stopwatch.start();
      print('START START START');
      updateScreen = new Timer.periodic(
          Duration(seconds: 1), (Timer timer) => setState(() {}));
      print('END END END');
    } else {
      toggleFAB(false);
      stopwatch.stop();
      setState(() {});
      updateScreen.cancel();
    }
  }

  //-----FAB VALUES------
  Icon fabIcon = Icon(Icons.play_arrow);
  Color fabColor = Colors.green;

  void toggleFAB(bool) {
    if (bool == true) {
      fabIcon = Icon(Icons.stop);
      fabColor = Colors.red;
    } else {
      fabIcon = Icon(Icons.play_arrow);
      fabColor = Colors.green;
    }
  }

  //------COMMANDS-------

  Stopwatch stopwatch = Stopwatch();
  Timer updateScreen;

  Duration displayTime() {
    Duration t = stopwatch.elapsed + initialTime;
    return Duration(seconds: t.inSeconds);
  }

  int displayMins() {
    return displayTime().inMinutes -
        (displayTime().inHours * Duration.minutesPerHour);
  }

  int displaySecs() {
    return displayTime().inSeconds -
        (displayTime().inMinutes * Duration.secondsPerMinute);
  }

  //---------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('$title'),
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () async {
              Navigator.pop(context, "From BackButton");

              deactivate();
            }),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.local_play),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return null; //TODO: Change null to Achievements Page
                }));
              }),
          IconButton(
              icon: Icon(Icons.pie_chart),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return null; //TODO: Change null to Stats Page
                }));
              }),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              displayTime().inHours.toString(),
              style: kUiNumber,
            ),
            Text(
              'Hours',
              style: kUiText,
            ),
            Text(
              displayMins().toString(),
              style: kUiNumber,
            ),
            Text(
              'Minutes',
              style: kUiText,
            ),
            Text(
              displaySecs().toString(),
              style: kUiNumber,
            ),
            Text(
              'Seconds',
              style: kUiText,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: fabIcon,
        backgroundColor: fabColor,
        onPressed: () => fabPressed(),
      ),
    );
  }
}
