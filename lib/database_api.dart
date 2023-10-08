import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:syncverse/model.dart';
import 'package:http/http.dart' as http;

class API extends GetxController {
  final String apiUrl = 'https://svdatabase.onrender.com/sv';
  final String targetEmail = 'ayan@gmail.com';
  // final RxList<UserData> filteredData = RxList<UserData>();
  final RxList<UserData> filteredData = <UserData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> data = responseData['data'];
        filteredData.clear();
        filteredData.addAll(data
            .where((entry) => entry['email'] == targetEmail)
            .map((entry) => UserData.fromJson(entry))
            .toList());
        print('im working API class');
        
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }
}
