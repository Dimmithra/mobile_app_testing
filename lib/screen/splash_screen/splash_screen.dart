import 'package:flutter/material.dart';
import 'package:mobile_app_test/providers/auth_provider.dart';
import 'package:mobile_app_test/utils/main_body.dart';
import 'package:mobile_app_test/widgets/common_loader.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<AuthProvider>(context, listen: false)
            .checkSingStatus(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.getloadingAlreadySingCheck) {
            return Center(
              child: CommonLoader(),
            );
          }
          return Image(
            image: AssetImage(
              "assets/images/splash.jpg",
            ),
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width * 2,
          );
        },
      ),
    );
  }
}
