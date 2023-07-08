class chatResponse{
String key, message;

chatResponse({required this.key, required this.message});

factory chatResponse.fromJson(Map<String,dynamic> json ){
  return chatResponse(key: json['key'], message: json['message']);
}

Map<String, dynamic> toJson(){
  return{"key":key,"message":message};
}



}