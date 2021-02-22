import 'package:bounty_hub_client/bloc/auth/authorization_bloc.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/profile_page.dart';
import 'package:bounty_hub_client/ui/pages/task_details/widgets/add_dialogs.dart';
import 'package:bounty_hub_client/ui/widgets/custom_appbar.dart';
import 'package:bounty_hub_client/ui/widgets/top_sheet_widget.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
import 'package:flutter/material.dart';

typedef void OnSelect();  // калбек без параметров, как воидкалбек
// typedef void OnSelect(EnumType itemType);   // это тип коллбека в который можно передать параметры

class SettingsMenuDialog extends StatefulWidget {
  final OnSelect onSelect;

  SettingsMenuDialog._(
    this.onSelect,
  );

  /// onSelect это каллбек, ты можешь передать в него енам,
  /// а в месте вызова сделать свитч по енаму и обрабатывать клики.
  /// Или же можешь сделать для каждой кнопки свой каллбек.
  /// Или можешь вовсе не делать каллбеки, а прям здесь описать всю логику, а это свой кубит и тд.
  static Future<void> show(
    BuildContext context,
    void onSelect(), {

    height = 200,  // высота не динамическая, нужно задать руками. Динамическая высота возможна но это дешевле
  }) async {
    return showDialog(
        context: context,
        builder: (context) => TopSheet(
            SettingsMenuDialog._(
              onSelect,
            ),
            height: double.tryParse(height.toString())),
        barrierColor: Colors.transparent);
  }

  @override
  _SettingsDialogState createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsMenuDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: AppStrings.settings,
          rightIcon: 'assets/images/reject.png',
          onRightIconClick: () {
            TopSheetState.close(context);
          },
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: ListTile(
            leading: Image.asset(
              'assets/images/key.png',
              width: 36,
              height: 36,
            ),
            title: Text(AppStrings.logOut, style: AppTextStyles.settingsTextStyle),
            onTap: () {
              showConfirmActionDialog(context, AppStrings.logOutConfirm, () {
                logout(context);
              }, () {
                Navigator.of(context).pop();
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: ListTile(
            leading: Image.asset(
              'assets/images/edit_icon.png',
              width: 28,
              height: 28,
            ),
            title: Text(AppStrings.editAccountData, style: AppTextStyles.settingsTextStyle),
            onTap: () {
              TopSheetState.close(context);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ProfilePage(showBackButton: true))
              );
            },
          ),
        ),
      ],
    );
  }
}