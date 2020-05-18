
import 'package:Borhan_User/models/campaign.dart';
import 'package:Borhan_User/notifiers/campaign_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

getCampaigns(CampaignNotifier campaignNotifier) async{
 QuerySnapshot snapshot= await Firestore.instance.collection('campaigns').getDocuments();
 
 List<Campaign> _campaignList  =[];
 snapshot.documents.forEach((document){

   Campaign campaign = Campaign.fromMap(document.data);

   _campaignList.add(campaign);

 });

 campaignNotifier.campaignList = _campaignList;

}