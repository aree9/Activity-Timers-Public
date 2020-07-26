import 'package:activity_timers/events/timer_events.dart';
import 'package:activity_timers/model/ActivityTimer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//CODE PRODUCED AFTER FOLLOWING GUIDE FROM 'Coding With Curry' (2020) [SOURCE FOUND IN PICTORIAL]
// CODE WAS NOT COPIED FROM SOURCE BUT SIMILARITIES MAY OCCUR AS THIS PROJECT SHARES PRINCIPALS REGARDING DATABASE ACCESS

class TimerBloc extends Bloc<TimerEvent, List<ActivityTimer>> {
  @override
  List<ActivityTimer> get initialState => List<ActivityTimer>();

  @override
  Stream<List<ActivityTimer>> mapEventToState(TimerEvent event) async* {
    if (event is SetTimers) {
      yield event.timerList;
    } else if (event is AddTimer) {
      List<ActivityTimer> newState = List.from(state);
      if (event.newTimer != null) {
        newState.add(event.newTimer);
      }
      yield newState;
    } else if (event is UpdateTimer) {
      List<ActivityTimer> newState = List.from(state);
      newState[event.timerIndex] = event.newTimer;
      yield newState;
    }
  }
}
