
import 'package:flutter/material.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/stayles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shopapp/network/cach_helper/cach_helper.dart';
import '../login/login-Screan/login_screan.dart';

class OnBordingModle{
  String image;
  String title;
  String body;

  OnBordingModle({
    this.image,
    this.title,
    this.body
});
}

class OnBordingScrean extends StatelessWidget {

  List<OnBordingModle> bordingPages=[
    OnBordingModle(
      image: 'assets/images/bb.jpg',
      title:'Image 1 Title' ,
      body: 'Image 1 Body',
    ),
    OnBordingModle(
        image: 'assets/images/bbb.jpg',
        title:'Image 2 Title' ,
        body: 'Image 2 Body',
    ),
    OnBordingModle(
        image: 'assets/images/b.jpg',
        title:'Image 3 Title' ,
        body: 'Image 3 Body',
    ),
  ];

  void submit(context){
    CashHelper.putData(key: 'OnBording', value: true).then((value){
      navigateToAndFinish(context, LoginScrean());
    }).catchError((error){
      print(error.toString());
    });
  }

  var bordingController = PageController();

  bool isLast=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                submit(context);
              },
              child: Text(
                'SKIP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
                ),
              )
          )
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index){
                  if(index==bordingPages.length-1)
                    isLast=true;
                  else
                    isLast=false;
                },
                physics: BouncingScrollPhysics(),
                controller: bordingController,
                itemBuilder: (context, index) => bulidOnBordingItem(page: bordingPages[index]),
                itemCount: bordingPages.length,
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: bordingController,
                  effect: ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                    dotColor: Colors.grey,
                    activeDotColor: defulteColor,
                  ),
                  count:  bordingPages.length,

                )  ,
                Spacer(),
                FloatingActionButton(
                  child: Icon(Icons.arrow_forward_ios),
                  onPressed: (){
                    if(isLast){
                      submit(context);
                    }else{
                      bordingController.nextPage(
                          duration:Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn
                      );
                    }

                  },
                    )
              ],
            ),
          ],
        ),
      )
    );
  }

  Widget bulidOnBordingItem({
  @required OnBordingModle page,
})=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage(page.image),
        ),
      ),
      SizedBox(
        height: 15,
      ),
      Text(
       '${page.title}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 16,
      ),
      Text(
        '${page.body}',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
        ),
      )
    ],
  );
}
