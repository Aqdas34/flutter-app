import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:only_shef/common/constants/show_snack_bar.dart';
import 'package:only_shef/pages/cuisine/models/chef.dart';

import '../../../common/constants/global_variable.dart';
import '../../../common/constants/http_response.dart';

class ChefAppointmentServices {
  Future<List<Chef>> getAvailableChefsByDate(
    BuildContext context,
    String date,
  ) async {
    List<Chef> chefList = [];

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/searchByDate?date=$date'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandling(
        response: res,
        // ignore: use_build_context_synchronously
        context: context,
        onSuccess: () {
          final List<dynamic> jsonData = jsonDecode(res.body);

          chefList = jsonData.map((json) => Chef.fromJson(json)).toList();
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously

      showSnackBar(context, e.toString());
    }
    return chefList;
  }
}
