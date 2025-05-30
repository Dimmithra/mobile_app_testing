import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_test/providers/home_provider.dart';
import 'package:mobile_app_test/utils/main_body.dart';
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
                child: ListView.builder(
                  itemCount:
                      homeProvider.gethotelListResultModelData!.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        color: Colors.white,
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  'https://via.placeholder.com/150', // fallback URL
                              imageBuilder: (context, imageProvider) =>
                                  Container(
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
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ],
                        ));
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
