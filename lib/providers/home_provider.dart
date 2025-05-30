import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_app_test/model/hotel_list_result_model.dart';
import 'dart:developer' as dev;

import 'package:mobile_app_test/utils/custom_http.dart';
import 'package:mobile_app_test/utils/url_constant.dart';
import 'package:mobile_app_test/widgets/common_snackbar_message.dart';

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
      dev.log(response.toString());
      HotelListResultModel temp =
          HotelListResultModel.fromJson(jsonDecode(response));
      if (temp.status == 200) {
        sethotelListResultModelData(temp);
      } else {
        SnackBarUtils.showSnackBar(context, message: temp.data.toString());
      }
    } catch (e) {
      dev.log(e.toString());
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
}
