import 'package:Borhan_User/notifiers/activity_notifier.dart';
import 'package:Borhan_User/notifiers/campaign_notifier.dart';
import 'package:Borhan_User/providers/chat_provider.dart';
import 'package:Borhan_User/providers/email_provider.dart';
import 'package:Borhan_User/providers/mydonation_provider.dart';
import 'package:Borhan_User/screens/Help_organizations.dart';
import 'package:Borhan_User/screens/chat_screen.dart';
import 'package:Borhan_User/screens/email_organization.dart';
import 'package:Borhan_User/screens/external_donation_screen.dart';
import 'package:Borhan_User/screens/help_screen.dart';
import 'package:Borhan_User/screens/my_donation_screen.dart';
import 'package:Borhan_User/screens/overview_screen.dart';
import 'package:Borhan_User/screens/welcomeScreen.dart';
import 'package:Borhan_User/providers/auth.dart';
import 'package:Borhan_User/providers/usersProvider.dart';
import 'package:Borhan_User/screens/Notification_screen.dart';
import 'package:Borhan_User/screens/favourite_screen.dart';
import 'package:devicelocale/devicelocale.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';
import 'package:Borhan_User/screens/login_screen.dart';
import 'package:Borhan_User/screens/signup_screen.dart';
import 'app_localizations.dart';
import 'notifiers/organization_notifier.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//  List _languages = List();
//  String _locale;

  @override
  void initState() {
    super.initState();
//    initPlatformState();
  }
//
//  Future<void> initPlatformState() async {
//    List languages;
//    String currentLocale;
//
//    // Platform messages may fail, so we use a try/catch PlatformException.
//    try {
//      languages = await Devicelocale.preferredLanguages;
////      print(languages);
//    } catch (PlatformException) {
//      print("Error obtaining preferred languages");
//    }
//    try {
//      currentLocale = await Devicelocale.currentLocale;
//      print(currentLocale);
//    } catch (PlatformException) {
//      print("Error obtaining current locale");
//    }
//    // If the widget was removed from the tree while the asynchronous platform
//    // message was in flight, we want to discard the reply rather than calling
//    // setState to update our non-existent appearance.
//    if (!mounted) return;
//
//    setState(() {
//      _languages = languages;
//      _locale = currentLocale;
//    });
//  }

  @override
  Widget build(BuildContext context) {
//    print("from main build " + _languages[0].toString());
//    print('current locale: ' + _locale);

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
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
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
                )),
            supportedLocales: [
              Locale('en', 'US'),
              Locale('ar', 'EG'),
            ],
            // These delegates make sure that the localization data for the proper language is loaded
            localizationsDelegates: [
              // THIS CLASS WILL BE ADDED LATER
              // A class which loads the translations from JSON files
              AppLocalizations.delegate,
              // Built-in localization of basic text for Material widgets
              GlobalMaterialLocalizations.delegate,
              // Built-in localization for text direction LTR/RTL
              GlobalWidgetsLocalizations.delegate,
            ],
            // Returns a locale which will be used by the app
            localeResolutionCallback: (locale, supportedLocales) {
              // Check if the current device locale is supported
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode &&
                    supportedLocale.countryCode == locale.countryCode) {
                  return supportedLocale;
                }
              }
              // If the locale of the device is not supported, use the first one
              // from the list (English, in this case).
              return supportedLocales.first;
            },
            home: WelcomeScreen(),
            routes: {
              '/Favourite': (context) => Favourite(),
              '/Home': (context) => OrgOverviewScreen(),
              '/Notifications': (context) => Notifications(),
              '/Login': (context) => LoginScreen(),

              '/Signup': (context) => SignupScreen(),
              '/ExternalDonation': (context) => ExternalDonation(),

              HelpScreen.routeName: (ctx) => HelpScreen(),
              EmailOrganization.routeName: (ctx) => EmailOrganization(),
              ChatScreen.routeName: (ctx) => ChatScreen(),
//              FirestoreChatScreen.routeName: (ctx) => FirestoreChatScreen(),

              HelpOrganization.routeName: (ctx) => HelpOrganization(),
              MyDonationsScreen.routeName: (ctx) => MyDonationsScreen(),
            }));
  }
}
