import 'package:activity_timers/model/ActivityTimer.dart';

//CODE PRODUCED AFTER FOLLOWING GUIDE FROM 'Coding With Curry' (2020) [SOURCE FOUND IN PICTORIAL]
// CODE WAS NOT COPIED FROM SOURCE BUT SIMILARITIES MAY OCCUR AS THIS PROJECT DEVELOPS UP PRINCIPALS LEARNED IN GUIDE

abstract class TimerEvent {}

class SetTimers extends TimerEvent {
  List<ActivityTimer> timerList;

  SetTimers(List<ActivityTimer> timers) {
    timerList = timers;
  }
}

class UpdateTimer extends TimerEvent {
  ActivityTimer newTimer;
  int timerIndex;

  UpdateTimer(int index, ActivityTimer timer) {
    newTimer = timer;
    timerIndex = index;
  }
}

class AddTimer extends TimerEvent {
  ActivityTimer newTimer;

  AddTimer(ActivityTimer timer) {
    newTimer = timer;
  }
}
