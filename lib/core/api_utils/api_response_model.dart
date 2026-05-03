class ApiResponseModel<T> {
  const ApiResponseModel({
    required this.data,
    required this.statusCode,
    this.message,
  });

  final T data;
  final int statusCode;
  final String? message;
}
