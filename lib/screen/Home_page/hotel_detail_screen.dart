import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_test/main.dart';
import 'package:mobile_app_test/providers/home_provider.dart';
import 'package:mobile_app_test/utils/colors.dart';
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
      container: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 300,
                    width: 300,
                    child: CachedNetworkImage(
                      imageUrl: widget.largeImage,
                      height: 300,
                      width: 300,
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.mode(
                              Colors.red,
                              BlendMode.colorBurn,
                            ),
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Image(
                        image: AssetImage("assets/images/hotel.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Column(
                  children: [
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kDefTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      widget.discription,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: const Color.fromARGB(255, 102, 102, 102),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
