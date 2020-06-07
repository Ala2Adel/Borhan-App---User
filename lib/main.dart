import 'package:Borhan_User/notifiers/activity_notifier.dart';
import 'package:Borhan_User/notifiers/campaign_notifier.dart';
import 'package:Borhan_User/providers/chat_provider.dart';
import 'package:Borhan_User/providers/connectivity_provider.dart';
import 'package:Borhan_User/providers/email_provider.dart';

import 'package:Borhan_User/providers/mydonation_provider.dart';
import 'package:Borhan_User/screens/Help_organizations.dart';
import 'package:Borhan_User/screens/chat_screen.dart';
import 'package:Borhan_User/screens/email_organization.dart';
import 'package:Borhan_User/screens/firebase_login_screen.dart';
import 'package:Borhan_User/screens/firestore_chat_screen.dart';
import 'package:Borhan_User/screens/google_signin.dart';
import 'package:Borhan_User/screens/help_screen.dart';
import 'package:Borhan_User/screens/my_donation_screen.dart';
import 'package:Borhan_User/screens/organization_activities.dart';
import 'package:Borhan_User/screens/overview_screen.dart';
import 'package:Borhan_User/screens/welcomeScreen.dart';
import 'package:Borhan_User/providers/auth.dart';
import 'package:Borhan_User/providers/usersProvider.dart';
import 'package:Borhan_User/screens/Notification_screen.dart';
import 'package:Borhan_User/screens/favourite_screen.dart';
import 'package:Borhan_User/screens/profile_screen.dart';
import 'package:Borhan_User/widgets/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
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
          ChangeNotifierProvider.value(
            value: MyDonationsProvider(),
          ),
          ChangeNotifierProvider.value(
            value: ConnectivityProvider(),
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
              primarySwatch: Colors.deepPurple,
              textTheme: TextTheme(
                subtitle1: TextStyle(
                fontFamily: ArabicFonts.Amiri,
                package: 'google_fonts_arabic',
                ), 
                button: TextStyle(
                fontFamily: ArabicFonts.Amiri,
                package: 'google_fonts_arabic',
                ),
                bodyText1: TextStyle(
                fontFamily: ArabicFonts.Amiri,
                package: 'google_fonts_arabic',
                 ),
               bodyText2: TextStyle(
                fontFamily: ArabicFonts.Amiri,
                package: 'google_fonts_arabic',
                ),   
              ) 
            ),
            home:
         
             WelcomeScreen(),
           // LocationSelection()

            routes: {
//      OrganizationDetails.routeName: (ctx) => OrganizationDetails(),
//      OrganizationActivity.routeName: (ctx) => OrganizationActivity(),
//      Donation.routeName: (ctx) => Donation(),

              '/Favourite': (context) => Favourite(),
              '/Home': (context) => OrgOverviewScreen(),
              '/Notifications': (context) => Notifications(),
              '/Login': (context) => LoginScreen(),
//              '/FirebaseLogin': (context) => AuthScreen(),
//              '/GoogleSignin': (context) => SignInDemo(),

              '/Signup': (context) => SignupScreen(),
              '/Profile': (context) => Profile(),
              HelpScreen.routeName: (ctx) => HelpScreen(),
              EmailOrganization.routeName: (ctx) => EmailOrganization(),
              ChatScreen.routeName: (ctx) => ChatScreen(),
//              FirestoreChatScreen.routeName: (ctx) => FirestoreChatScreen(),

              HelpOrganization.routeName: (ctx) => HelpOrganization(),
              MyDonationsScreen.routeName: (ctx) => MyDonationsScreen(),
            }));
  }
}
