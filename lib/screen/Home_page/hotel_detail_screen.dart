import 'package:flutter/material.dart';
import 'package:mobile_app_test/main.dart';
import 'package:mobile_app_test/providers/home_provider.dart';
import 'package:mobile_app_test/utils/main_body.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HotelDetailScreen extends StatefulWidget {
  const HotelDetailScreen({
    super.key,
    required this.title,
    required this.discription,
    required this.largeImage,
    required this.latitude,
    required this.longatude,
  });
  final String longatude;
  final String latitude;
  final String largeImage;
  final String title;
  final String discription;
  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MainBodyScreen(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Consumer<HomeProvider>(
            builder: (context, homeProvider, child) {
              return IconButton(
                onPressed: () {
                  homeProvider.openGoogleMap(
                    context,
                    latitude: widget.latitude,
                    longitude: widget.longatude,
                  );
                },
                icon: FaIcon(
                  FontAwesomeIcons.locationDot,
                  color: Colors.black,
                  size: 30,
                ),
              );
            },
          ),
        ),
      ],
      appBarTitle: Text("Details"),
      automaticallyImplyLeading: true,
      appbar: true,
      // endDrawer: IconButton(
      //   onPressed: () {},
      //   icon: FaIcon(
      //     FontAwesomeIcons.map,
      //     color: Colors.red,
      //     size: 50,
      //   ),
      // ),
      container: SingleChildScrollView(),
    );
  }
}
