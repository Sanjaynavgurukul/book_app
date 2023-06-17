class ApiResponse{
  String message;
  bool status;
  Map<String ,dynamic> data;

  //Default Constructor :D
  ApiResponse({required this.status,required this.data,required this.message});
}