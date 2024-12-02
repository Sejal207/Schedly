class ClassSchedule {
  final String name;
  final String time;
  final String room;

  ClassSchedule({
    required this.name,
    required this.time,
    required this.room,
  });
}

class DailySchedule {
  final String day;
  final List<ClassSchedule> classes;

  DailySchedule({
    required this.day,
    required this.classes,
  });
}
