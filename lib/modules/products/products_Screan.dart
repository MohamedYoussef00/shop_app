
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/categories_data_model/categories_model.dart';
import 'package:shopapp/models/home_data_model/home_model.dart';
import 'package:shopapp/modules/home_layout/cubit/home_cubit.dart';
import 'package:shopapp/modules/home_layout/cubit/home_states.dart';
import 'package:shopapp/shared/stayles/colors.dart';

class ProductsScrean extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context, state) {} ,
      builder:(context,state){
        return ConditionalBuilder(
            condition: ShopCubit.get(context).model!=null&&ShopCubit.get(context).c_model!=null,
            builder:(context){
             return homeBuilder(ShopCubit.get(context).model,ShopCubit.get(context).c_model,context);
            } ,
            fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      } ,
    );
  }

  Widget homeBuilder(HomeModel model,CategoriesModel c_model,context){
    return SingleChildScrollView(
      child: Column(
        children: [

          CarouselSlider(
              items: model.data.banners.map((e) =>Image(
                image: NetworkImage('${e.image}'),
                fit: BoxFit.cover,
                width: double.infinity,
              )).toList(),
              options: CarouselOptions(
                height: 200,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayAnimationDuration:Duration(seconds: 1) ,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1,
              )
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 100,
                  width: double.infinity,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>buildCategoryListItem(c_model.data.data[index]),
                      separatorBuilder: (context,index)=>SizedBox(width: 8,),
                      itemCount:c_model.data.data.length,
                  ),
                ),

                SizedBox(
                  height: 15,
                ),
                Text(
                  'Productes',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),

          Container(
            color: Colors.grey[300],
            child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                crossAxisCount: 2,
                childAspectRatio: 1/1.42,
                children: List.generate(
                  model.data.products.length,
                      (index) =>  buildGridView(model.data.products[index],context),
                )),
          ),
        ],
        ),
    );
  }
  Widget buildGridView (Products product,context){
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${product.image}'),
                width: double.infinity,
                height: 150,
              ),
              if(product.discount!=0)
                Container(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        height: 1.3
                    ),
                  ),
                  Spacer(),
                  
                  Row(
                    children: [
                      Text(
                        product.price.round().toString(),
                        style: TextStyle(
                          fontSize: 13,
                          color: defulteColor,
                        ),
                      ),
                      SizedBox(width: 5,),
                      if(product.discount!=0)
                        Text(
                          product.old_price.round().toString(),
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),

                      IconButton(
                        onPressed: (){
                          ShopCubit.get(context).changeFavoritProduct(product.id);
                        },
                        icon: CircleAvatar(
                          radius: 20,
                          backgroundColor:ShopCubit.get(context).favoritProduct[product.id]?defulteColor: Colors.grey,
                          child: Icon(
                              Icons.favorite_border,
                            color: Colors.white,
                          )
                        ),
                      ),


                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildCategoryListItem(Data categ_data){
    return  Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(categ_data.image),
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
          width:100,
          color: Colors.black.withOpacity(0.7),
          child: Text(
            categ_data.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),

      ],
    );
  }
}
