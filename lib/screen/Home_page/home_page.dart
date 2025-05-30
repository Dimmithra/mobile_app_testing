import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_test/providers/auth_provider.dart';
import 'package:mobile_app_test/providers/home_provider.dart';
import 'package:mobile_app_test/screen/Home_page/hotel_detail_screen.dart';
import 'package:mobile_app_test/utils/colors.dart';
import 'package:mobile_app_test/utils/main_body.dart';
import 'package:mobile_app_test/widgets/common_list_card.dart';
import 'package:mobile_app_test/widgets/common_loader.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.email,
    required this.name,
    required this.profilePrc,
  });

  final String email;
  final String name;
  final String profilePrc;

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
      container: Consumer2<HomeProvider, AuthProvider>(
        builder: (context, homeProvider, authProvider, child) {
          if (homeProvider.getloadHomePageData) {
            return Center(
              child: CommonLoader(),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        child: CachedNetworkImage(
                          imageUrl: widget.profilePrc,
                          height: MediaQuery.of(context).size.height / 3,
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
                      Text(
                        "${widget.name}",
                        style: TextStyle(
                          color: kDefTextColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "${widget.email}",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 97, 97, 97),
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      authProvider.getloadingLogout
                          ? CommonLoader()
                          : InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: Text(
                                        "Confirm Logout",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      content: Text(
                                        "Are you sure you want to log out?",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          onPressed: () {
                                            authProvider.userLogOut(context);
                                          },
                                          child: Text(
                                            "Yes",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.green.shade900),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "No",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                );

                                // authProvider.userLogOut(context);
                              },
                              child: Container(
                                width: 180,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: kButtonColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Logout",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
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
