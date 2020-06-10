//import 'package:beautiful_list/model/lesson.dart';
import 'package:Borhan_User/Animation/FadeAnimation.dart';
import 'package:Borhan_User/models/user_nav.dart';
import 'package:Borhan_User/notifiers/activity_notifier.dart';
import 'package:Borhan_User/providers/shard_pref.dart';
import 'package:Borhan_User/screens/normal_donation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ActivityDetails extends StatefulWidget {
  //final Lesson lesson;
 // DetailPage({Key key, this.lesson}) : super(key: key);
  @override
  _ActivityDetailsState createState() => _ActivityDetailsState();
}

class _ActivityDetailsState extends State<ActivityDetails> {
  bool isFirstTime=true;
  String myTitle = "default title";
  ActivityNotifier  activityNotifier;

   void _showErrorDialog(String message) {
    print("alert");
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const  Text('تسجيل دخول'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: const  Text('ليس الأن'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          FlatButton(
            child:const  Text('نعم'),
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.pushNamed(context, '/Login');
            },
          ),
        ],
      ),
    );
  }
Future<UserNav> loadSharedPrefs() async {
    UserNav user;
    try {
     SharedPref sharedPref = SharedPref();
       user = UserNav.fromJson(await sharedPref.read("user"));
      } catch (Excepetion) {
    // do something
       }
       return user;
   } 

  @override
  Widget build(BuildContext context) {
     if(isFirstTime){
        activityNotifier =
        Provider.of<ActivityNotifier>(context, listen: false);
        isFirstTime=false; 
      }
    return Scaffold(
      body: nested(),
    );
  }


   body(){

     return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                 height: 100,
              ),
              Container(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  //color: Colors.deepPurple.withOpacity(0.75),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(0),
                        topLeft: Radius.circular(20)),
                    color: Colors.deepPurple.withOpacity(0.75),
                    //  boxShadow: [
                    //  BoxShadow(
                    //   color: Colors.purple,
                    //   blurRadius: 5,
                    //   offset: Offset(5, 5),
                    //   )
                    //  ],
                  ),
                  child: Text(' الوصف',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        // backgroundColor: Colors.lightBlue[600],

                        shadows: [
                          Shadow(
                              color: Colors.grey[600],
                              blurRadius: 2.0,
                              offset: Offset(4, 2))
                        ]),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                1.7,
                Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 15 ,vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(196, 135, 198, .3),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      )
                    ],
                  ),
                  child: Text( activityNotifier.currentActivity.description,
                    //'وَأَطْعِمُوا الطَّعَامَ، وَصِلُوا الْأَرْحَامَ، وَصَلُّوا بِاللَّيْلِ وَالنَّاسُ نِيَامٌ تَدْخُلُوا الْجَنَّةَ بِسَلَامٍ',
                  style: TextStyle(
                    fontSize: 18),
                   )
                ),
              ),
              SizedBox(
                height: 40,
              ),
               FadeAnimation(
                      1.9,
                      Builder(
                        builder: (ctx) => InkWell(
                          onTap: ()async {
                          
                   UserNav userLoad = await loadSharedPrefs();
                    if(userLoad==null){
                      print("user is not here");
                      _showErrorDialog("برجاء تسجيل الدخول أولا ");
                     }else{
                       print("user is  here");
                       Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) {
                      return NormalDenotationScreen();
                      },
                     ),
                    );
                     }
                          }
                            , // handle your onTap here
                          child: Center(
                            child: Container(
                            height: 50,
                            width:MediaQuery.of(context).size.width*2/5 ,
                            // margin: EdgeInsets.symmetric(horizontal: 60),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color.fromRGBO(49, 39, 79, 1),
                            ),
                            child: Center(
                              child: Text(
                                "تبرع الأن",
                                style: TextStyle(color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                              ),
                          ),
                        ),
                      ),
                    ),
              // SizedBox(
              //   height: 20,
              // ),
            ],
          ),
        ),
      );
   }


   nested() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        // print("add is $add");
        return <Widget>[
            SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  backgroundColor: Colors.blue,
                  pinned: true,
                  expandedHeight: MediaQuery.of(context).size.height*4/9,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    //color: Colors.deepPurple.withOpacity(0.75),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      color: Colors.blue.withOpacity(0.75),
                      //  boxShadow: [
                      //  BoxShadow(
                      //   color: Colors.purple,
                      //   blurRadius: 5,
                      //   offset: Offset(5, 5),
                      //   )
                      //  ],
                    ),
                    child: Text(activityNotifier.currentActivity.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                
                  // background: Image.asset(
                  //   "assets/burhan.jpg",
                  background: Stack(children: <Widget>[
                    Positioned(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(activityNotifier.currentActivity.image,
                               // "https://sydneycoupleandfamily.com/wp-content/uploads/2017/12/family-therapy-sydney.jpg",
                                ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    //    Positioned(
                    //   child:
                    //  ),
                    ],
                    ),
                  ),
                ),
              ),
         
        ];
      },
      body: body(),
    );
   }

}



 // SliverAppBar(
          //   expandedHeight: MediaQuery.of(context).size.height*4/9 ,
          //   floating: false,
          //   pinned: true,

          //   backgroundColor: Colors.purple[700],
          //   flexibleSpace: LayoutBuilder(
          //       builder: (BuildContext context, BoxConstraints constraints) {
          //        print('constraints=' + constraints.toString());
                 
          //       top = constraints.biggest.height.round();
          //        if(top==80){
          //         add=80;
          //        }else{
          //         add=0;
          //        }
          //       return  FlexibleSpaceBar(
          //         centerTitle: true,
          //         title: Text(myTitle,
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 16.0,
          //           ),
          //         ),
                
          //         // background: Image.asset(
          //         //   "assets/burhan.jpg",
          //         background: Stack(children: <Widget>[
          //           Positioned(
          //             child: Container(
          //               decoration: BoxDecoration(
          //                 image: DecorationImage(
          //                   image: NetworkImage(
          //                       "https://sydneycoupleandfamily.com/wp-content/uploads/2017/12/family-therapy-sydney.jpg"),
          //                   fit: BoxFit.fill,
          //                 ),
          //               ),
          //             ),
          //           ),
          //           //    Positioned(
          //           //   child:
          //           //  ),
          //           ],
          //           ),
          //         );
          //         }
          //         ,
                
          //   ),
          //  ),
          //  SliverPersistentHeader(
          //       delegate:  _SliverAppBarDelegate(),
          //       pinned: true,
          //     ),

