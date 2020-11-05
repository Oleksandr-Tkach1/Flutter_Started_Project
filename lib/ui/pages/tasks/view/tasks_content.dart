import 'package:bounty_hub_client/ui/pages/my_tasks/view/my_tasks_page.dart';
import 'package:bounty_hub_client/ui/pages/tasks/tasks_cubit.dart';
import 'package:bounty_hub_client/ui/pages/tasks/tasks_state.dart';
import 'package:bounty_hub_client/ui/pages/tasks_list/view/tasks_list_page.dart';
import 'package:bounty_hub_client/ui/widgets/app_button.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksContent extends StatefulWidget {
  @override
  _TasksContentState createState() => _TasksContentState();
}

class _TasksContentState extends State<TasksContent> {

  TasksCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.bloc<TasksCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: Dimens.content_padding, right: Dimens.content_padding),
                height: 42,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        height: 42,
                        text: 'All Tasks',
                        decoration: state.currentTab == 0 ? WidgetsDecoration.appButtonStyle() : WidgetsDecoration.appDisabledButtonStyle(),
                        textColor: state.currentTab == 0 ? AppColors.buttonDefaultTextColorPrimary : AppColors.itemTextColor,
                        onPressed: () {
                          _cubit.onTabClick(0);
                        },
                      ),
                    ),
                    SizedBox(width: Dimens.content_internal_padding),
                    Expanded(
                      child: AppButton(
                        height: 42,
                        text: 'My To Do',
                        textColor: state.currentTab == 1 ? AppColors.buttonDefaultTextColorPrimary : AppColors.itemTextColor,
                        decoration: state.currentTab == 1 ? WidgetsDecoration.appButtonStyle() : WidgetsDecoration.appDisabledButtonStyle(),
                        onPressed: () {
                          _cubit.onTabClick(1);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 42 + Dimens.content_internal_padding,),
                child: state.currentTab == 0 ? TasksListPage() : MyTasksPage(),
              ),
            ],
          ),
        );
      },
    );
  }
}