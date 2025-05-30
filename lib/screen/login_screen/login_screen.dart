import 'package:flutter/material.dart';
import 'package:mobile_app_test/providers/auth_provider.dart';
import 'package:mobile_app_test/utils/colors.dart';
import 'package:mobile_app_test/utils/main_body.dart';
import 'package:mobile_app_test/widgets/common_loader.dart';
import 'package:mobile_app_test/widgets/common_textfeild.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return MainBodyScreen(
      appbar: false,
      container: Center(
        child: SingleChildScrollView(
          child: Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return Column(
                children: [
                  Text(
                    "Welcome Back!",
                    style: TextStyle(
                      color: kDefTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "Login",
                    style: TextStyle(
                      color: kDefTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(
                          "assets/images/login_image.png",
                        ),
                        height: MediaQuery.of(context).size.height / 5,
                        width: 200,
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      authProvider.signInWithGoogle(context);
                    },
                    child: authProvider.getsignInLoader
                        ? CommonLoader()
                        : Container(
                            width: 180,
                            height: 50,
                            decoration: BoxDecoration(
                                color: kButtonColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.google,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Google",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
