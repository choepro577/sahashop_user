class CustomException implements Exception {
  final int statusCode;

  final String message;

  @override
  String toString() => message.toString();

  CustomException({this.statusCode, this.message});
}


class NetworkException implements Exception {
  int statusCode;
  String message;

  String toString() => (message ?? "").toString();

  NetworkException([this.statusCode, this.message]) {

    if(this.message.contains('SocketException'))
      this.message = "Kết nối máy chủ thất bại.\nVui lòng kiểm tra kết nối mạng !";
  }
}