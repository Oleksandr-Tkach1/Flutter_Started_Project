import 'package:bounty_hub_client/data/enums/social_networks_types.dart';
import 'package:bounty_hub_client/data/models/entity/user/social.dart';
import 'package:bounty_hub_client/ui/pages/profile/widgets/social_description_widgets/social_description_pre_next_widget.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'social_description_post_next_widget.dart';
import 'social_ui_utils.dart';

class SocialDescriptionWidget extends StatefulWidget {

  SocialDescriptionWidget(
    this.selectedSocial, {
    Key key,
    this.shortNumber,
    this.nextBtnWasPressed,
     this.social,
  }) : super(key: key);

  final int shortNumber;
  final bool nextBtnWasPressed;
  final selectedSocial;
  final Socials social;


  @override
  _SocialDescriptionWidgetState createState() =>
      _SocialDescriptionWidgetState();
}

class _SocialDescriptionWidgetState extends State<SocialDescriptionWidget> {
  Map<SocialNetworkType, SocialUIModel> uIModels;

  @override
  void initState() {
    uIModels = initUIModels(widget.shortNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedModel = uIModels[widget.selectedSocial];
    return widget.social == null
        ? widget.nextBtnWasPressed
            ? SocialDescriptionPostNextWidget(selectedModel: selectedModel)
            : SocialDescriptionPreNextWidget(
                selectedModel: selectedModel,
                shortNumber: widget.shortNumber,
                selectedSocial: widget.selectedSocial,
              )
        : _buildExistingSocial(selectedModel);
  }

  _buildExistingSocial(SocialUIModel selectedModel) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        selectedModel.name,
        style: AppTextStyles.smallBoldTitle,
      ),
      SizedBox(
        height: 16,
      ),
      Container(
        height: 50,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color: AppColors.socialDescription,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            border:
                Border.all(color: AppColors.socialDescriptionBorder, width: 2)),
        child: Text(
          widget.social?.accountUrl??'',
          style: AppTextStyles.defaultText,
        ),
      )
    ]);
  }
}

class SocialUIModel {
  final String name;
  final String title;
  final String subTitle;
  final String bottomText;
  final List<List<String>> text;
  final List<List<bool>> isTextBold;
  final String nextText;
  final String example;

  const SocialUIModel(this.name,
      {this.title,
      this.subTitle,
      this.bottomText,
      this.text,
      this.isTextBold,
      this.nextText,
      this.example});
}
