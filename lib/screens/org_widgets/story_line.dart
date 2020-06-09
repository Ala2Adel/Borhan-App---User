import 'package:Borhan_User/models/organization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Storyline extends StatefulWidget {
  Storyline(this.storyline);
  final Organization storyline;

  @override
  _StorylineState createState() => _StorylineState();
}

class _StorylineState extends State<Storyline> {
  var more =true;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الوصف',
          style: textTheme.subhead.copyWith(fontSize: 24.0),
        ),
        SizedBox(height: 5.0),
        Text(
          widget.storyline.description,
        //  'وَأَطْعِمُوا الطَّعَامَ، وَصِلُوا الْأَرْحَامَ، وَصَلُّوا بِاللَّيْلِ وَالنَّاسُ نِيَامٌ تَدْخُلُوا الْجَنَّةَ بِسَلَامٍ',
          style: textTheme.body1.copyWith(
            color: Colors.black45,
            fontSize: 18.0,
          ),
        ),
      if(!more)  
       Container(
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text(
            'العنوان',
            style: textTheme.subhead.copyWith(fontSize: 21.0),
          ),
          SizedBox(height: 5.0),
          Text(
            widget.storyline.address,
            style: textTheme.body1.copyWith(
              color: Colors.black45,
              fontSize: 18.0,
            ),
          ),
           Text(
            'البريد الألكترونى',
            style: textTheme.subhead.copyWith(fontSize: 21.0),
          ),
          SizedBox(height: 5.0),
          Text(
            widget.storyline.email,
            style: textTheme.body1.copyWith(
              color: Colors.black45,
              fontSize: 18.0,
            ),
          ),
           Text(
            ' رقم التليفون المحمول',  
            style: textTheme.subhead.copyWith(fontSize: 21.0),
          ),
          SizedBox(height: 5.0),
          Text(
            widget.storyline.mobileNo,
            style: textTheme.body1.copyWith(
              color: Colors.black45,
              fontSize: 18.0,
            ),
          ),
          Text(
            ' رابط صفحة الإنترنت ',
            style: textTheme.subhead.copyWith(fontSize: 21.0),
          ),
          SizedBox(height: 5.0),
          Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: InkWell(
                onTap: () => launch(widget.storyline.webPage),
                child: Text(
                 widget.storyline.webPage,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.blue),
                     
                ),
                
              ),
            ),
          ),
          ]
         ,
        ),
     )
      ,
       
        // No expand-collapse in this tutorial, we just slap the "more"
        // button below the text like in the mockup.
        
        InkWell(
           onTap: (){
             setState(() {
               more=!more;
             });
           },
           child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(more?'المزيد':'اقل',
                style: textTheme.body1
                    .copyWith(fontSize: 18.0, color: theme.accentColor),
              ),
              Icon(more?Icons.keyboard_arrow_down:Icons.keyboard_arrow_up,
                size: 20.0,
                color: theme.accentColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
