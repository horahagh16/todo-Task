import 'package:todo1_app/forms/task.dart';

class Tasks {
  static List<task> tasks=List.empty(growable: true);

  static void add(task task) {
    tasks.add(task);
  }

  static List<task> taskGetter() {
    return tasks;
  }
}
