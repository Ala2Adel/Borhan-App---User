import 'dart:convert';
import 'package:Borhan_User/models/campaign.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:translator/translator.dart';

class CampaignNotifier with ChangeNotifier {
  List<Campaign> _campaignList = [];
  List<Campaign> _translatedCampaignList = [];

  List<Campaign> get translatedCampaignList {
    return [..._translatedCampaignList];
  }

  Campaign _currentCampaign;

  Campaign get currentCampaign => _currentCampaign;

  set currentCampaign(Campaign campaign) {
    _currentCampaign = campaign;
    notifyListeners();
  }

  List<Campaign> get campaignList {
    return [..._campaignList];
  }

  Future<void> fetchAndSetProducts() async {
    const url = 'https://borhanadmin.firebaseio.com/Campaigns.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      final List<Campaign> loadedCampaigns = [];
      if (extractedData != null) {
        extractedData.forEach((prodId, prodData) {
          loadedCampaigns.add(Campaign(
            id: prodId,
            campaignName: prodData['name'],
            campaignDescription: prodData['description'],
            orgId: prodData['orgId'],
            orgName: prodData['orgName'],
            imagesUrl: prodData['image'],
            time: prodData['time'],
          ));
        });
      }
      final List<Campaign> translatedCampaigns = [];
      if (extractedData != null) {
        extractedData.forEach((prodId, prodData) {
          translatedCampaigns.add(Campaign(
            id: prodId,
            campaignName: prodData['name'],
            campaignDescription: prodData['description'],
            orgId: prodData['orgId'],
            orgName: prodData['orgName'],
            imagesUrl: prodData['image'],
            time: prodData['time'],
          ));
        });
      }
      final translator = new GoogleTranslator();

      _campaignList = loadedCampaigns;
      _translatedCampaignList = translatedCampaigns;
      for (var i = 0; i < loadedCampaigns.length; i++) {
        _translatedCampaignList[i].orgName = await translator
            .translate(_campaignList[i].orgName, from: 'ar', to: 'en');
        _translatedCampaignList[i].campaignName = await translator
            .translate(_campaignList[i].campaignName, from: 'ar', to: 'en');
        _translatedCampaignList[i].campaignDescription =
            await translator.translate(_campaignList[i].campaignDescription,
                from: 'ar', to: 'en');
        _translatedCampaignList[i].time = await translator
            .translate(_campaignList[i].time, from: 'ar', to: 'en');
      }

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
