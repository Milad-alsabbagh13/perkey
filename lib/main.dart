import 'package:flutter/material.dart';
import 'package:perkey/core/constants.dart';
import 'package:perkey/core/shared/user_model.dart';
import 'package:perkey/features/business/views/business_home_view.dart';
import 'package:perkey/features/home/views/vidoe_view.dart';
import 'package:perkey/features/influencer/views/influencer_home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize user info
  await UserInfo().init();

  // Decide start page
  late Widget homePage;

  if (UserInfo().isLoggedIn) {
    if (UserInfo().type == SharedPreferencesConstants.kInfluencerValue) {
      homePage = InfluencerHomeView();
    } else {
      homePage = BusinessHomeView();
    }
  } else {
    homePage = VideoView();
  }
  runApp(MyApp(homePage: homePage));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.homePage});
  final Widget homePage;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        ),
        home: homePage,
      ),
    );
  }
}
