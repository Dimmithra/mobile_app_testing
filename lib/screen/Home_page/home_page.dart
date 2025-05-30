import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_test/providers/home_provider.dart';
import 'package:mobile_app_test/screen/Home_page/hotel_detail_screen.dart';
import 'package:mobile_app_test/utils/main_body.dart';
import 'package:mobile_app_test/widgets/common_list_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<HomeProvider>(context, listen: false)
            .getHotelsRecord(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainBodyScreen(
      appBarTitle: Text("List View"),
      container: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          if (homeProvider.getloadHomePageData) {
            return CircularProgressIndicator();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Date: 2025-05-30"),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Email: example@email.com"),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: homeProvider.gethotelListResultModelData != null
                    ? ListView.builder(
                        itemCount: homeProvider
                            .gethotelListResultModelData!.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CommonListCard(
                            imageurl: homeProvider.gethotelListResultModelData!
                                .data![index].image!.small
                                .toString(),
                            title: homeProvider
                                .gethotelListResultModelData!.data![index].title
                                .toString(),
                            address: homeProvider.gethotelListResultModelData!
                                .data![index].address
                                .toString(),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HotelDetailScreen(
                                    discription:
                                        "${homeProvider.gethotelListResultModelData!.data![index].description}",
                                    latitude:
                                        "${homeProvider.gethotelListResultModelData!.data![index].latitude}",
                                    longatude:
                                        "${homeProvider.gethotelListResultModelData!.data![index].longitude}",
                                    title:
                                        "${homeProvider.gethotelListResultModelData!.data![index].title}",
                                    largeImage:
                                        "${homeProvider.gethotelListResultModelData!.data![index].image!.large}",
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                    : Text("No recode availabe"),
              ),
            ],
          );
        },
      ),
    );
  }
}
