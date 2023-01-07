import 'dart:convert';
import 'package:http/http.dart' as http;

String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiI3MmQzYzQ0YS1hY2EwLTRkMDItYTZiNi1jYTc0ZjRlNDdiNjQiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTY3MzA2NzMxMCwiZXhwIjoxNjczNjcyMTEwfQ.nJUpyrDvoyl07DYOEzY3_9GwcOP6lPoLT9CKzOwv-Ks";

Future<String> createMeeting() async {
  final http.Response httpResponse = await http.post(
    Uri.parse("https://api.videosdk.live/v2/rooms"),
    headers: {'Authorization': token},
  );

  return json.decode(httpResponse.body)['roomId'];
}
