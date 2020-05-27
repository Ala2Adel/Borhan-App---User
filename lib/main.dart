import 'package:Borhan_User/notifiers/activity_notifier.dart';
import 'package:Borhan_User/notifiers/campaign_notifier.dart';
import 'package:Borhan_User/providers/chat_provider.dart';
import 'package:Borhan_User/providers/email_provider.dart';
import 'package:Borhan_User/screens/Donation.dart';
import 'package:Borhan_User/screens/chat_screen.dart';
import 'package:Borhan_User/screens/email_screen.dart';
import 'package:Borhan_User/screens/help_screen.dart';
import 'package:Borhan_User/screens/organization_activities.dart';
import 'package:Borhan_User/screens/organization_details.dart';
import 'package:Borhan_User/screens/overview_screen.dart';
import 'package:Borhan_User/screens/splashScreen.dart';
import 'package:Borhan_User/providers/auth.dart';
import 'package:Borhan_User/providers/usersProvider.dart';
import 'package:Borhan_User/screens/Notification_screen.dart';
import 'package:Borhan_User/screens/donation_history.dart';
import 'package:Borhan_User/screens/favourite_screen.dart';
import 'package:Borhan_User/screens/profile_screen.dart';
import 'package:Borhan_User/screens/support_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Borhan_User/screens/login_screen.dart';
import 'package:Borhan_User/screens/signup_screen.dart';

import './screens/location_selection.dart';
import 'notifiers/organization_notifier.dart';

import 'package:Borhan_User/screens/fast_donation.dart';


import 'models/campaign.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: CampaignNotifier(),
          ),
          ChangeNotifierProvider.value(
            value: OrganizationNotifier(),
          ),
          ChangeNotifierProvider.value(
            value: UsersPtovider(),
          ),
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProvider.value(
            value: ActivityNotifier(),
          ),
          ChangeNotifierProvider.value(
            value: EmailProvider(),
          ),
          ChangeNotifierProvider.value(
            value: ChatProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
            builder: (BuildContext context, Widget child) {
              return new Directionality(
                textDirection: TextDirection.rtl,
                child: new Builder(
                  builder: (BuildContext context) {
                    return new MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        textScaleFactor: 1.0,
                      ),
                      child: child,
                    );
                  },
                ),
              );
            },
            title: 'Borhan',
            theme: new ThemeData(
              primarySwatch: Colors.blueGrey,
            ),
            home:
            OrganizationActivity()
            // SplashScreen()
           // LocationSelection()
            home: 
            SplashScreen()
            //LocationSelection()
            
            ,
            routes: {
//      OrganizationDetails.routeName: (ctx) => OrganizationDetails(),
//      OrganizationActivity.routeName: (ctx) => OrganizationActivity(),
//      Donation.routeName: (ctx) => Donation(),

              '/DonationHistory': (context) => DonationHistory(),
              '/Favourite': (context) => Favourite(),
              '/Home': (context) => OrgOverviewScreen(),
              '/Notifications': (context) => Notifications(),
              '/Login': (context) => LoginScreen(),
              '/Signup': (context) => SignupScreen(),
              '/Profile': (context) => Profile(),
              '/Support': (context) => Support(),
              HelpScreen.routeName: (ctx) => HelpScreen(),
              EmailScreen.routeName: (ctx) => EmailScreen(),
              ChatScreen.routeName: (ctx) => ChatScreen(),
            }));
  }
}
