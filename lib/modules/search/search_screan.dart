
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/search_model/search_model.dart';
import 'package:shopapp/modules/home_layout/cubit/home_cubit.dart';
import 'package:shopapp/modules/home_layout/cubit/home_states.dart';
import 'package:shopapp/modules/search/cubit/search_cubit.dart';
import 'package:shopapp/shared/components/components.dart';

import '../../shared/stayles/colors.dart';
import 'cubit/search_states.dart';

class SearchScrean extends StatelessWidget {
  @override
  var searchController =TextEditingController();
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context, state) {},
        builder: (context,state)=>Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  decoration:InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search',
                    suffixIcon: Icon(Icons.search),
                  ),
                  onChanged: (text){
                    SearchCubit.get(context).getSearchData(text);

                  },
                ),
                SizedBox(height: 20,),
                if(state is GetSearchLodingState)
                  LinearProgressIndicator(),
                if(state is GetSearchSaccesseState)
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index)=>buildSearchItem(SearchCubit.get(context).searchModel.data.data[index], context),
                    separatorBuilder:(context,index) =>Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                    itemCount: SearchCubit.get(context).searchModel.data.data.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }


  Widget buildSearchItem(SearchProductData product,context)=>Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      height: 100,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(product.image),
                width: 100,
                height: 100,
              ),
            ],
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
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
                      product.price.round().toString(),
                      style: TextStyle(
                        color: defulteColor,
                        fontSize: 14,
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
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
