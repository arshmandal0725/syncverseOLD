import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:syncverse/model.dart';
import 'package:http/http.dart' as http;

class ProfileeController extends GetxController {
  final String apiUrl = 'https://svdatabase.onrender.com/sv';
  final String userinfo = 'https://svdatabase.onrender.com/sv/userinfodata';
  final String targetEmail = 'harsh@gmail.com';
  final RxList<UserData> filteredData = RxList<UserData>();

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

        filteredData.addAll(data
            .where((entry) => entry['email'] == targetEmail)
            .map((entry) => UserData.fromJson(entry))
            .toList());
        print('im working profile controller class');
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  // Post data
}
