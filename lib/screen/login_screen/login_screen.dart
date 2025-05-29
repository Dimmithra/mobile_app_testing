import 'package:flutter/material.dart';
import 'package:mobile_app_test/providers/auth_provider.dart';
import 'package:mobile_app_test/utils/main_body.dart';
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: InkWell(
                      onTap: () {
                        authProvider.signInWithGoogle();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Colors.white60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.googlePlus,
                              color: Colors.red,
                              size: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
