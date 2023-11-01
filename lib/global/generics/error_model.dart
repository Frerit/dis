class ErrorResponse {
  final int status;
  final String message;
  final dynamic stack;

  ErrorResponse({required this.status, required this.message, this.stack});
}
