import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_test/utils/colors.dart';

class CommonListCard extends StatelessWidget {
  const CommonListCard({
    super.key,
    required this.imageurl,
    required this.title,
    required this.address,
    required this.onTap,
  });

  final String imageurl;
  final String title;
  final String address;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black38,
            ),
          ),
        ),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          children: [
            CircleAvatar(
              child: CachedNetworkImage(
                imageUrl: imageurl,
                height: MediaQuery.of(context).size.height / 5,
                width: 200,
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
                errorWidget: (context, url, error) => Image(
                  image: AssetImage(
                    "assets/images/hotel.png",
                  ),
                  height: MediaQuery.of(context).size.height / 5,
                  width: 200,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: Text(
                      title.toString(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: kDefTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: Text(
                      address.toString(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: const Color.fromARGB(255, 114, 114, 114),
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
