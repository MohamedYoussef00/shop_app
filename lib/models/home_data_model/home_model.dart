
class HomeModel {
  bool status;
  String message;
  HomeData data;
  HomeModel.fromjason(Map<String,dynamic>json){
    this.status=json['status'];
    this.message=json['message'];
    data=HomeData.fromjason(json['data']);
  }
}

class HomeData{
  List<Banners> banners=[];
  List<Products> products=[];
  String ad;
  HomeData.fromjason(Map<String,dynamic>json){
    json['banners'].forEach((element){
      banners.add(Banners.fromjason(element));
    });

    json['products'].forEach((element){
      products.add(Products.fromjason(element));
    });

    this.ad=json['ad'];
  }
}

class Banners{
  int id;
  String image;
  Banners.fromjason(Map<String,dynamic>json){
    this.id=json['id'];
    this.image=json['image'];
  }
}
class Products{
  int id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String image;
  String name;
  String description;
  List<String> images=[];
  bool in_favorites;
  bool in_cart;

  Products.fromjason(Map<String,dynamic>json){
    this.id=json['id'];
    this.price=json['price'];
    this.old_price=json['old_price'];
    this.discount=json['discount'];
    this.image=json['image'];
    this.name=json['name'];
    this.description=json['description'];

    json['images'].forEach((item){
      images.add(item);
    });

    this.in_favorites=json['in_favorites'];
    this.in_cart=json['in_cart'];


  }
}