import 'package:bounty_hub_client/ui/pages/dashboard/dashboard.dart';
import 'package:bounty_hub_client/ui/pages/login/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/authorization_bloc.dart';
import 'bloc/authorization_state.dart';
import 'utils/ui/colors.dart';

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BountyHub',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        primaryColor: AppColors.primaryColor,
        accentColor: AppColors.accentColor,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Authenticated) {
            return DashboardPage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}