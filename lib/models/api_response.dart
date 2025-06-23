class ApiResponse {
  final int id;
  final int status;
  final String? url;
  final List<int> bytes;

  ApiResponse(this.id, this.status, this.url, this.bytes);

}