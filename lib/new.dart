import 'package:http/http.dart' as http;
import 'dart:convert';

var headers = {"accept": "application/json", "content-type": "application/json", "Authorization": "Basic OTlmMjcxNDYtZjcyYy00NTA3LWJiZjktYWUwZTVhMGUzOGU5"};

void main () {
  http.post(
  Uri.parse("https://api.onesignal.com/notifications"), headers: headers, body: jsonEncode({
                          "included_segments": [
    "Total Subscriptions",
  ],
                          "app_id": "ce9b9e00-1c44-4c39-8972-b791f8bca0e3",
                          "contents": {"en": "English Message", "es": "Spanish Message"},
                          "headings": {"en": "English Title", "es": "Spanish Title"}

                        })
).then((value) => print(value.body+" "+value.statusCode.toString()));

}