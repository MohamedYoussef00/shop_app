
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/login/cubit/login_states.dart';
import '../login/cubit/login_cubit.dart';

class SettingScrean extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context, state) {},
        builder: (context,state)=>Scaffold(
          backgroundColor: Colors.black12,
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container (
                  decoration:BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0) //                 <--- border radius here
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.star),
                      SizedBox(width: 10,),
                      Text(
                        'ABOUT US',
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.navigate_next),
                    ],
                  ),
                ),
                SizedBox(height: 3,),
                Container (
                  decoration:BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0) //                 <--- border radius here
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.rate_review_outlined),
                      SizedBox(width: 10,),
                      Text(
                        'Rate App',
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.navigate_next),
                    ],
                  ),
                ),
                SizedBox(height: 3,),
                InkWell(
                  onTap: () {
                   LoginCubit().Logout(context:context);
                  },
                  child: Container (
                    decoration:BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0) //                 <--- border radius here
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: 10,),
                        Text(
                          'LOGOUT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.navigate_next),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }

}
