import 'package:intl/intl.dart';

import '../../data/models/task_model/task_model.dart';
import '../../data/models/todo_model/todo_model.dart';

extension TodoActivity on List<Todo> {
  int numberOfCompletedTask() {
    var count = 0;
    // get number of completed task
    for (var i in this) {
      if (i.tasks.every((task) => task.isDone == true)) {
        count++;
      }
    }

    return count;
  }

  int numberOfunCompletedTask() {
    var count = 0;
    // get number of completed task
    for (var i in this) {
      if (i.tasks.any((task) => task.isDone == false)) {
        count++;
      }
    }

    return count;
  }
}

extension FormatDateTime on DateTime {
  String formateDateTime() => DateFormat('EEEE h:mm a', 'en_US').format(this);
  String formateDay() => DateFormat('MMMM dd', 'en_US').format(this);
}

extension NumberOfCompletedTask on List<Task> {
  int numberOfCompletedTask() {
    int count = where((element) => element.isDone == true)
        .fold(0, (previousValue, element) => (previousValue + 1));

    return count;
  }
}
