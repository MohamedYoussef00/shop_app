
class SearchModel{
  bool status;
  String message;
  SearchData data;

  SearchModel.fromJson(Map<String,dynamic>json){
    this.status=json['status'];
    this.message=json['message'];
    print('enaaaaaaaaaaaaaaaaaaaaaaaaa');
    this.data=SearchData.formJson(json['data']);

  }
}


class SearchData{
  int current_page;
  List<SearchProductData> data=[];

  SearchData.formJson(Map<String,dynamic>json){
    this.current_page=json['current_page'];
    json['data'].forEach(( value)=>data.add(SearchProductData.fromJson(value)));
  }

}


class SearchProductData{
  int id;
  dynamic price;
  String image;
  String name;
  String description;
  List<String>images=[];
  bool in_favorites;
  bool in_cart;
  SearchProductData.fromJson(Map<String,dynamic>json){
    this.id=json['id'];
    this.price=json['price'];
    this.image=json['image'];
    this.name=json['name'];
    this.description=json['description'];
    json['images'].forEach((element)=>this.images.add(element));
    this.in_favorites=json['in_favorites'];
    this.in_cart=json['in_cart'];
  }

}