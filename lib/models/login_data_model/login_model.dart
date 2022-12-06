
class LoginModle {

  bool status;
  String message;
  UserData data;

  LoginModle.Fromjson(Map<String,dynamic>json){
    this.status=json['status'];
    this.message=json['message'];
    data=json['data']!=null?UserData.Fromjson(json['data']):null;
  }
}

class UserData {
  int id;
  String name;
  String email;
  String phone;
  String image;
  int points;
  int credit;
  String token;

  UserData.Fromjson(Map<String,dynamic>json){
    this.id=json['id'];
    this.name=json['name'];
    this.email=json['email'];
    this.phone=json['phone'];
    this.image=json['image'];
    this.points=json['points'];
    this.credit=json['credit'];
    this.token=json['token'];
  }
}