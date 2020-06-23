import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'overview_screen.dart';

class OnboardScreen extends StatelessWidget {
  
  final pages = [
    PageViewModel(
        pageColor: Colors.blue[500],
  
        bubble: Image.asset('assets/images/donation4.png'),
        body: Text( 'حصّنوا أموالكم بالزكاة و داووا مرضاكم بالصدقة و إستقبلوا أمواج البلاء بالدعاء و التضرع',
            style: new TextStyle(
                fontFamily: ArabicFonts.Amiri,
                package: 'google_fonts_arabic',
                fontSize: 18,
              ),
        ),
        title: Text(
          'نقود',
           style: new TextStyle(
                fontFamily: ArabicFonts.Amiri,
                package: 'google_fonts_arabic',
                fontSize: 44,
              ),
        ),
        titleTextStyle: TextStyle(fontFamily:'MyFont' , color: Colors.white),
        bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        mainImage: Image.asset(
          'assets/images/mdonation2.png',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
          fit: BoxFit.cover,
          ),
        ),
    PageViewModel(
      pageColor: const Color(0xFF8BC34A),
      iconImageAssetPath: 'assets/images/donation5.png',
      body: Text(
        'وَأَطْعِمُوا الطَّعَامَ، وَصِلُوا الْأَرْحَامَ، وَصَلُّوا بِاللَّيْلِ وَالنَّاسُ نِيَامٌ تَدْخُلُوا الْجَنَّةَ بِسَلَامٍ',
         style: new TextStyle(
                fontFamily: ArabicFonts.Amiri,
                package: 'google_fonts_arabic',
                fontSize: 18,
              ),
      ),
      title:  Text('طعام',
       style: new TextStyle(
                fontFamily: ArabicFonts.Amiri,
                package: 'google_fonts_arabic',
                fontSize: 44,
              ),
              ),
      mainImage: Image.asset(
        'assets/images/donation2.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
    PageViewModel(
      pageColor: Colors.grey[350],
      iconImageAssetPath: 'assets/images/donation9.png',
      body: Text(
        'ما نقصت صدقة من مال ، وما زاد الله عبدا بعفو إلا عزاً ، وما تواضع أحد لله إلا رفعة الله',
         style: new TextStyle(
                fontFamily: ArabicFonts.Amiri,
                package: 'google_fonts_arabic',
                fontSize: 18,
              ),
      ),
      title: Text('ملابس',
       style: new TextStyle(
                fontFamily: ArabicFonts.Amiri,
                package: 'google_fonts_arabic',
                fontSize: 44,
               ),
              ),
      mainImage: Image.asset(
        'assets/images/donation9.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.black),
      bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.black),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          showNextButton: true,
          showBackButton: true,
          onTapDoneButton: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                   builder: (context) => OrgOverviewScreen(),
                  // builder: (context) => AnimatedNav(),
                // builder: (context) => MyHomePage2(),
              ), //MaterialPageRoute MyHomePage2
            );
          },
          doneText:Text('حسنا',
           style: new TextStyle(
                fontFamily: ArabicFonts.Amiri,
                package: 'google_fonts_arabic',
                fontSize: 21,
               ),
              ) ,
          skipText:Text('تخطى',
           style: new TextStyle(
                fontFamily: ArabicFonts.Amiri,
                package: 'google_fonts_arabic',
                fontSize: 21,
               ),
              ) ,
          nextText: Text('التالى',
           style: new TextStyle(
                fontFamily: ArabicFonts.Amiri,
                package: 'google_fonts_arabic',
                fontSize: 21,
               ),
              ),
          backText:Text('رجوع',
          style: new TextStyle(
                fontFamily: ArabicFonts.Amiri,
                package: 'google_fonts_arabic',
                fontSize: 21,
               ),
              ),
          pageButtonTextStyles: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ), //IntroViewsFlutter
      ), //Builder
    ); //Material App
  }
}