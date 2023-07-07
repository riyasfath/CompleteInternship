import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:my_grocery/const.dart';

class RemoteCategoryService {
  var client = http.Client();

  var remoteUrl = "$baseUrl/api/categories";

  Future<dynamic> get() async {
    try {
      log('populate=image');
      var response = await client.get(Uri.parse('$remoteUrl?populate=image'));
      return response;
    } catch (e) {
      log(e.toString());
    }
  }
}
