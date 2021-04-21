class Task {
  String name;
  bool isDone;
  Task({this.isDone = false, this.name});
  void toggleIsDone() {
    isDone = !isDone;
    // print('Is done=$isDone');
  }
}
