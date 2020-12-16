import 'package:bounty_hub_client/bloc/auth/authentication_event.dart';
import 'package:bounty_hub_client/bloc/auth/authorization_bloc.dart';
import 'package:bounty_hub_client/bloc/badge/badge_cubit.dart';
import 'package:bounty_hub_client/bloc/locale/locale_bloc.dart';
import 'package:bounty_hub_client/data/repositories/activities_repository.dart';
import 'package:bounty_hub_client/data/repositories/campaigns_repository.dart';
import 'package:bounty_hub_client/data/repositories/login_repository.dart';
import 'package:bounty_hub_client/data/repositories/profile_local_repository.dart';
import 'package:bounty_hub_client/data/repositories/profile_repository.dart';
import 'package:bounty_hub_client/data/repositories/tasks_repository.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:bounty_hub_client/network/server_api.dart';
import 'package:bounty_hub_client/ui/pages/activity/cubit/activity_cubit.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/bloc/profile_bloc.dart';
import 'package:bounty_hub_client/ui/pages/tasks/cubit/tasks_cubit.dart';
import 'package:bounty_hub_client/ui/pages/tasks_list/cubit/tasks_list_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

getRepositories(RestClient client) {
  return [
    RepositoryProvider<UserRepository>(create: (context) => UserRepository()),
    RepositoryProvider<CampaignRepository>(create: (context) => CampaignRepository(client)),
    RepositoryProvider<LoginRepository>(create: (context) => LoginRepository(client)),
    RepositoryProvider<TaskRepository>(create: (context) => TaskRepository(client)),
    RepositoryProvider<ProfileRepository>(create: (context) => ProfileRepository(client)),
    RepositoryProvider<ProfileLocalRepository>(create: (context) => ProfileLocalRepository()),
  ];
}

getProviders(RestClient client) {
  return [
    BlocProvider(create: (context) => AuthenticationBloc(UserRepository())..add(AppStarted())),
    BlocProvider(create: (context) => ProfileBloc(ProfileRepository(client), ProfileLocalRepository())),
    BlocProvider(create: (context) => LocaleBloc()),
    BlocProvider(create: (context) => ActivityCubit(ActivitiesRepository(client))),
    BlocProvider(create: (context) => ActivityBadgeCubit(ActivitiesRepository(client))),
    BlocProvider(create: (context) => TasksCubit(CampaignRepository(client))),
    BlocProvider(create: (context) => TasksListCubit(TaskRepository(client), UserRepository())),
  ];
}