
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/home_layout/cubit/home_cubit.dart';
import 'package:shopapp/modules/home_layout/cubit/home_states.dart';

import '../../models/categories_data_model/categories_model.dart';

class CatigoriesScrean extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShopCubit cubit=ShopCubit.get(context);
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (Context,state)=> ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) =>buildCatListItem(cubit.c_model.data.data[index]),
        separatorBuilder: (context,index)=> Container(
          color: Colors.grey,
          height: 1.0,
          width: double.infinity,
        ),
        itemCount: cubit.c_model.data.data.length,
      ),
    );
  }

  Widget buildCatListItem( Data data)=>Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(data.image),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          data.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        Spacer(),
        Icon(
          Icons.navigate_next,
        )
      ],
    ),
  );
}
