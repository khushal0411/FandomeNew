class postlikes{

String username;

postlikes({required this.username});

factory postlikes.fromJson(Map<String, dynamic> json){
  return postlikes(username: json['username'],
  );
}
Map<String, dynamic> toJson() {
    return {
      
      'username': username,
     
    };
  }

}