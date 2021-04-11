class ThreadData {
  static final ThreadData _singleton = ThreadData._internal();

  bool _isOnline = false;

  factory ThreadData() {
    return _singleton;
  }

  ThreadData._internal();

  isOnline() {
    return _isOnline;
  }
}
