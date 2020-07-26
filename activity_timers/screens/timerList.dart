import 'package:activity_timers/database/db_provider.dart';
import 'package:activity_timers/events/timer_events.dart';
import 'package:activity_timers/model/ActivityTimer.dart';
import 'package:activity_timers/screens/new_timer.dart';
import 'package:activity_timers/screens/timerScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:activity_timers/bloc/timer_bloc.dart';
import 'dart:convert';
import 'package:json_store/json_store.dart';

class TimerList extends StatefulWidget {
  const TimerList({Key key}) : super(key: key);

  @override
  _TimerListState createState() => _TimerListState();
}

class _TimerListState extends State<TimerList> {
  @override
  void initState() {
    super.initState();
    DatabaseProvider.db.getTimers().then(
      (timers) {
        BlocProvider.of<TimerBloc>(context).add(SetTimers(timers));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Timers'),
      ),
      body: Container(
        child: BlocConsumer<TimerBloc, List<ActivityTimer>>(
          builder: (context, timers) {
            return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  ActivityTimer timer = timers[index];
                  return ListTile(
                    title: Text(timer.title),
                    subtitle: Text(timer.duration.toString()),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TimerScreen(timer: timer, timerIndex: index),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemCount: timers.length);
          },
          listener: (BuildContext context, timers) {},
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return NewTimer();
              },
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
