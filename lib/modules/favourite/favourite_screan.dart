
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/home_data_model/home_model.dart';
import 'package:shopapp/modules/home_layout/cubit/home_states.dart';

import '../../models/get_favorits_model/get_favorite-model.dart';
import '../../shared/stayles/colors.dart';
import '../home_layout/cubit/home_cubit.dart';

class FavouriteScrean extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {} ,
        builder:(context, state) =>ConditionalBuilder(
          condition:state is !GetFavoriteLodingState ,
          builder:(context)=> ListView.separated(
            itemBuilder: (context, index) =>builFavListItem(ShopCubit.get(context).getFav_model.data.data[index],context) ,
            separatorBuilder: (context, index) =>Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey,
            ),
            itemCount: ShopCubit.get(context).getFav_model.data.data.length,
          ),
          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
        )  ,
    );

  }

  Widget builFavListItem(ProductData product,context)=>Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      height: 100,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(product.product.image),
                width: 100,
                height: 100,
              ),
               if(product.product.discount!=0)
              Container(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      product.product.price.round().toString(),
                      style: TextStyle(
                        color: defulteColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 5,),
                    if(product.product.discount!=0)
                    Text(
                      product.product.oldPrice.round().toString(),
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: (){
                          ShopCubit.get(context).changeFavoritProduct(product.product.id);
                      },
                      icon: CircleAvatar(
                          radius: 20,
                           backgroundColor:ShopCubit.get(context).favoritProduct[product.product.id]?defulteColor: Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          )
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
