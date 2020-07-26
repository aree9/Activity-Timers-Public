import 'package:activity_timers/screens/timerList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/timer_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimerBloc>(
      create: (context) => TimerBloc(),
      child: MaterialApp(
        home: TimerList(),
      ),
    );
  }
}
