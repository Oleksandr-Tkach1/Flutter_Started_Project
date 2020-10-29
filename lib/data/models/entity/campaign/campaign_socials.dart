import 'package:bounty_hub_client/data/enums/social_networks_types.dart';

class CampaignSocials {
  String id;
  String campaignSocial;
  String link;

  CampaignSocials.fromJson(dynamic json) {
    id = json["id"];
    campaignSocial = json["campaignSocial"];
    link = json["link"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["campaignSocial"] = campaignSocial;
    map["link"] = link;
    return map;
  }

  SocialNetworkType getSocialNetwork() {
    return campaignSocial != null && campaignSocial.isNotEmpty ? fromString(campaignSocial.toUpperCase()) : SocialNetworkType.OTHER;
  }
}