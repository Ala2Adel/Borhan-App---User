
import 'dart:collection';

import 'package:Borhan_User/models/campaign.dart';
import 'package:flutter/cupertino.dart';

class CampaignNotifier with ChangeNotifier {
  List <Campaign> _campaignList =[];
  Campaign _currentCampaign;

  UnmodifiableListView <Campaign> get campaignList => UnmodifiableListView(_campaignList);

  Campaign get currentCampaign => _currentCampaign;

  set campaignList (List<Campaign> campaignList){
    _campaignList = campaignList;
    notifyListeners();
  }

  set currentCampaign (Campaign campaign) {
    _currentCampaign = campaign;
    notifyListeners();
  }

}