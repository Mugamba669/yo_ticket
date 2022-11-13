import 'package:http/http.dart';

Future<Response> fetchData(String url) async {
  Client client = Client();
  return await client.get(Uri.parse(url), headers: {
    "Accept": "application/json",
    "Content-Type": "application/json"
  });
}
