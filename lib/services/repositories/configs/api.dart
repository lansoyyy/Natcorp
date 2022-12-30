import 'dart:convert';
import 'package:http/http.dart' as http;

String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiJkM2YzY2JmNy1kYzU5LTQwODItODRhMC0yZDliNmYwMTk2ZWIiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTY3MjM2NjkwMSwiZXhwIjoxNjcyOTcxNzAxfQ.fHwTPLYY0TURu9OsnZySAZD5DXNAXfJfR16yjx98vB8";

Future<String> createMeeting() async {
  final http.Response httpResponse = await http.post(
    Uri.parse("https://api.videosdk.live/v2/rooms"),
    headers: {'Authorization': token},
  );

  return json.decode(httpResponse.body)['roomId'];
}
