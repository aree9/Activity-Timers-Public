import 'package:activity_timers/database/db_provider.dart';

class ActivityTimer {
  int id;
  String title;
  Duration duration;

  ActivityTimer({this.id, this.title, this.duration});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_TITLE: title,
      DatabaseProvider.COLUMN_DURATION: duration.inMilliseconds
    };

    if (id != null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }
    return map;
  }

  ActivityTimer.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    title = map[DatabaseProvider.COLUMN_TITLE];
    duration = map[DatabaseProvider.COLUMN_DURATION];
  }
}
