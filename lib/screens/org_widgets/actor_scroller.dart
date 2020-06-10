import 'package:Borhan_User/models/activity.dart';
import 'package:Borhan_User/notifiers/activity_notifier.dart';
import 'package:Borhan_User/screens/activity_detail.dart';
import 'package:flutter/material.dart';
import 'package:Borhan_User/screens/org_widgets/models.dart';
import 'package:provider/provider.dart';

class ActorScroller extends StatelessWidget {
  ActorScroller(this.actors);
  final  List<Activity> actors;

   ActivityNotifier activityNotifier;

  Widget _buildActor(BuildContext ctx, int index) {
    var actor = actors[index];

    return InkWell(
        onTap: (){
          activityNotifier.currentActivity = actor ;
           Navigator.of(ctx).push(MaterialPageRoute(
           builder: (BuildContext context) {
                   return ActivityDetails();
                   },
                 ),
                );
        },
        child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(actor.image),
              radius: 40.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(actor.name),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
     activityNotifier = Provider.of<ActivityNotifier>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'الأنشطة',
            style: textTheme.subhead.copyWith(fontSize: 18.0),
          ),
        ),
        SizedBox.fromSize(
          size: const Size.fromHeight(120.0),
          child: ListView.builder(
            itemCount: actors.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 12.0, left: 20.0),
            itemBuilder: _buildActor,
          ),
        ),
      ],
    );
  }
}
