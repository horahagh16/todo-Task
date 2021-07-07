class task{
  String title;
  String description;
  bool isDone;
  DateTime time;

  task(String title, String description, bool isDone,DateTime time) {
    this.isDone = isDone;
    this.description = description;
    this.title = title;
    this.time=time;
  }
  void converter(){
    isDone=!isDone;
  }
  String getTitle(){
    return title;
  }
  String getDesc(){
    return description;
  }
  DateTime getTime(){
    return time;
  }
  bool getStatus(){
    return isDone;
  }
}


