import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  static const _credentials = r''' {
  "type": "service_account",
  "project_id": "fluttergsheets-371312",
  "private_key_id": "61203f38233b9cde3ffdf8687e403b135455d459",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDGjN6guzRutjtj\nRXm4Qxog3ubXjhNdrwVfi+Y+ciF7qFJKIWu6xUUHjeEYZMMcgFzz1JM0WRsQXse1\nB3Pk5WlNsfPlx9deeQTWj5TEa+D3Pb6JpmlDqi6lNE7F+9ZWTzg8WB5dKjtmMQD5\n92Uo0P1ea/IyWwpYK3BdiNh9jd6gODFS831Nvgx128m7GrYyRP3gZCNT+JvO9HZU\nUKi5d9VVjQ3/DHUcGjydjWpBnE/c6uYS7CwcOY8gkRnLBi1j7B/mAmnNsflaSMiL\n4zv97ZBWxRtrsn8+YZ6ZcdB3woeTqqFtoP0NaP1gfI1lz/i1mmznouGJhQMqq5id\nDZcpFwszAgMBAAECggEABOpT3tZY8GWa+XEQbT6zIx2hkAlxgNjmYO5/Qra5De0X\nSODAtcelyLpQdO7O/4Vpjs0Xw2WOqNqlKiUHFpUi6D4qc8y2EAFXauBmNHBte8bI\nplZl4LugRVSEn5xa5WCMsPcVgHa5oiwFu0brE8C2+mM2oNyCWGI5I+lt0NbLZT8X\nRuvw4VRd/3S4PJ8O+C5B59w4XGdXpX/CxsRof7Z38UEjmNJOHbnvNl3nEV/1gHhk\npNqe1pPbj9qu6du563NhQJL1UEOmpv32WPi4yhIvTxkxkiYWx773UYW7V1FXifZq\nsaDuSTCXiIQ25/12wfbPqZ/CimDR5b4xKK75oPb6gQKBgQDh/wyyerpfVcM7Gsr3\n5RZlVk3Lcd8pFp+rTPf7xA04DpVhiYg3qlbH3P/Nffx0lu7+1resC59fMG91hj3r\nIt1rTx75yz6QbvBF9pPxFioLXYMgKBniWEqQiCJl+xecvyUw7eP7L5D8wxs3t+NE\nJzQrUv7pXhL06AA36+0dPazy0wKBgQDg6QKy/apVvVBAbte2/PAiQEIjVFlBkXgP\nCf/nq9cn5INojAIBewMor8HOY1pTwS3nUaPOUDQGU+tG6e+9kA+udeU1XZHFR+MU\nr8Ecq+WGGoYlF/XgP0MRN2YkKLABsjxnRSLPh/l6tPuZz5j13W5PQcVb8G3W8kEY\n/R+wzcKKIQKBgAwJzQBY30Kiy+KDG9q2nknJnh0/NJb4uIqkb/U+TUH2LOjkLZhh\nf3vn/sxQcLk5LQPwJhqJB/VHHDjTbMrwsYC81zaRKAUDk9L2Po0yFA1E7u4wlKhk\n8ZvfVI3AIVLdL7r6gRFpSDzem72NExMXT4UbR67grvvSu+g+rgPHvEW3AoGBALPI\nLrsrYBRnXxYSRGbmq4GFghjBnRN3l9PVt3TV/QfLd2uDtzq9vRmx3KcA7jxTCEGH\nFfyeSefg/wpRh60s0gwv+4d8A0ECpLdtgl1L3w4id6aBD68wgojpksFGsOK6OeSG\n9DuWQstejlw2ANxQI5RBS+ShPPv77CNwevuWjnJhAoGAeRaUkxcf3fCoT4HPawOG\nEDK6A5FjNEpg3hFUjggqzijvuWCj0WR1Cj7AN3h51Jd3h7nKJNUcjeXxYWUUzQ1W\nBUg/GgjwFiInS4NOWZvFzwRMsj8IhXalffsl5kJ3q4ZSkaYAoZ+ktBelzjI+kXPi\nt3vwpsJUlE2MuCPuXoYOZno=\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-gsheets-tutorial@fluttergsheets-371312.iam.gserviceaccount.com",
  "client_id": "100066734552205309495",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-gsheets-tutorial%40fluttergsheets-371312.iam.gserviceaccount.com"
}
 ''';

  //  set up & connetct to the spreadsheet
  static const _spreadSheetId = '17HzAdqXDRlqRVwdn7qJEdfssNn10_yx67rVH6Awo1bw';
  static final _gsheet = GSheets(_credentials);
  static Worksheet? _worksheet;

  //  some variabiles to keep track of..
  static int numberOfNotes = 0;
  static List<String> currentNotes = [];
  static bool isLoading = true;

  // initialise the spreadsheet
  Future init() async {
    final sprdSht = await _gsheet.spreadsheet(_spreadSheetId);
    _worksheet = sprdSht.worksheetByTitle('MyWorkSheet 1');

    countRows();
  }

  //  count the number of notes
  static Future countRows() async {
    while (
        (await _worksheet!.values.value(column: 1, row: numberOfNotes + 1)) !=
            '') {
      numberOfNotes++;
    }

    //  now we know many notes to load, now let's loade them!

    loadeNotes();
  }

  //  load existing notes from google spreadsheet:
  static Future loadeNotes() async {
    if (_worksheet == null) return;

    for (int i = 0; i < numberOfNotes; i++) {
      final String newNote =
          await _worksheet!.values.value(column: 1, row: i + 1);

      if (currentNotes.length < numberOfNotes) {
        currentNotes.add(newNote);
      }
    }

    isLoading = false;
  }

  //  insert a new note
  static Future insertNote(String note) async {
    if (_worksheet == null) return;
    numberOfNotes++;
    currentNotes.add(note);

    await _worksheet!.values.appendRow([note]);
  }

  // delete a note
  static Future deleteNote(int index) async {
    if (_worksheet == null) return;

    await _worksheet!.deleteRow(index + 1);
    currentNotes.removeAt(index);
    numberOfNotes - 1;
  }
}
