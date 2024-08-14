import 'dart:typed_data';

import 'package:http/http.dart' as http;

class RemoveBgApi {
  static const apiKey = "NnvPVwaPCewS78yKJsjE4nLz";
  static var baseUrl = Uri.parse("https://api.remove.bg/v1.0/removebg");

  Future<Uint8List> removeBg(String imgPath) async {
    var req = http.MultipartRequest("Post", baseUrl);

    req.files.add(await http.MultipartFile.fromPath("image_file", imgPath));
    req.headers.addAll({"X-API-Key": apiKey});
    final res = await req.send();
    if (res.statusCode == 200) {
      http.Response img = await http.Response.fromStream(res);
      return img.bodyBytes;
    } else {
      throw Exception('Failed to fetch data ${res.statusCode}');
    }
  }
}
