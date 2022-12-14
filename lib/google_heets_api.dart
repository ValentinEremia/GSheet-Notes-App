import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  static const _credentials = r''' {
         --  Your google credentials  --
}
 ''';

  //  set up & connetct to the spreadsheet
  static const _spreadSheetId = '--  Your google sheet ID  --';
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
