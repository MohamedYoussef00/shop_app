
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/home_layout/cubit/home_cubit.dart';
import 'package:shopapp/modules/home_layout/cubit/home_states.dart';
import 'package:shopapp/modules/login/login-Screan/login_screan.dart';
import 'package:shopapp/modules/search/search_screan.dart';
import 'package:shopapp/network/cach_helper/cach_helper.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/stayles/colors.dart';

class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ShopCubit.get(context).currentIndex=0;
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){} ,
      builder: (context,state){
        ShopCubit cubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:Text('Shop App'),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScrean());
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          body: cubit.screans[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeCurrentIndex(index);
            },
            showUnselectedLabels: true,
            elevation: 10,
            unselectedItemColor: Colors.grey,
            selectedItemColor:defulteColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: 'Categories',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Setting'
              ),
            ],
          ),
        );
      }
    );
  }
}
