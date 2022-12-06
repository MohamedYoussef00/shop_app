
class FavoriteModel{

  bool status;
  String message;

  FavoriteModel.formJson(Map<String ,dynamic>json){
    this.status=json['status'];
    this.message=json['message'];
  }
}