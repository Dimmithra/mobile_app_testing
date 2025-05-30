import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_app_test/model/hotel_list_result_model.dart';
import 'dart:developer' as dev;

import 'package:mobile_app_test/utils/custom_http.dart';
import 'package:mobile_app_test/utils/url_constant.dart';
import 'package:mobile_app_test/widgets/common_snackbar_message.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeProvider extends ChangeNotifier {
  bool loadHomePageData = false;
  bool get getloadHomePageData => loadHomePageData;
  setloadHomePageData(val) {
    loadHomePageData = val;
    notifyListeners();
  }

  Future<void> getHotelsRecord(context) async {
    try {
      setloadHomePageData(true);
      final CommonHttp customHttp = CommonHttp("", "");
      var response = await customHttp.get(
        kHotelJson,
        context,
      );
      // dev.log(response.toString());
      HotelListResultModel temp =
          HotelListResultModel.fromJson(jsonDecode(response));
      if (temp.status == 200) {
        sethotelListResultModelData(temp);
      } else {
        SnackBarUtils.showSnackBar(context, message: temp.data.toString());
      }
    } catch (e) {
      // dev.log(e.toString());
    } finally {
      setloadHomePageData(false);
    }
  }

  HotelListResultModel? hotelListResultModelData;
  HotelListResultModel? get gethotelListResultModelData =>
      hotelListResultModelData;
  sethotelListResultModelData(val) {
    hotelListResultModelData = val;
    notifyListeners();
  }

  Future<void> openGoogleMap(
    BuildContext context, {
    dynamic latitude,
    dynamic longitude,
  }) async {
    try {
      final Uri googleUrl = Uri.parse(
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

      // dev.log('Trying to launch: $googleUrl');
      if (latitude != null && longitude != null) {
        launchUrl(
          googleUrl,
          mode: LaunchMode.inAppWebView,
        );
      } else {
        SnackBarUtils.showSnackBar(context,
            message: "Could Not Open google map ${googleUrl}");
      }
    } catch (e) {
      // dev.log("error-" + e.toString());
    } finally {}
  }
}
