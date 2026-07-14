import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

class CalendarHelper {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/calendar',
    ],
  );

  Future<List<Event>> getGoogleCalendarEvents() async {
    try {
      // Ensure user is signed in
      final GoogleSignInAccount? googleUser =
          await _googleSignIn.signInSilently();

      if (googleUser == null) return [];

      // authenticatedClient is called on _googleSignIn, not googleUser
      final httpClient = await _googleSignIn.authenticatedClient();

      if (httpClient == null) return [];

      final calendarApi = CalendarApi(httpClient);

      // Fetch events from the primary calendar for the next 30 days
      final now = DateTime.now();
      final end = now.add(const Duration(days: 30));

      final events = await calendarApi.events.list(
        'primary',
        timeMin: now.toUtc(),
        timeMax: end.toUtc(),
        singleEvents: true,
        orderBy: 'startTime',
      );

      return events.items ?? [];
    } catch (e) {
      print('Error fetching calendar events: $e');
      return [];
    }
  }
}
