import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsheets_project/google_heets_api.dart';
import '../note_text_card.dart';

class NotesGrid extends StatefulWidget {
  const NotesGrid({super.key});

  @override
  State<NotesGrid> createState() => _NotesGridState();
}

class _NotesGridState extends State<NotesGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: GoogleSheetsApi.currentNotes.length,
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: [
            MyTextCard(text: GoogleSheetsApi.currentNotes[index]),
            Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  _showAlertDialog(context, index);
                },
                child: const CircleAvatar(
                  radius: 11,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  // This shows a dialog box for  DELETE NOTES option.
  void _showAlertDialog(BuildContext context, int index) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: const Text(
          'Do you want to delete\n this note?',
          style: TextStyle(fontSize: 16),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () async {
              await GoogleSheetsApi.deleteNote(index);
              Navigator.of(context).pop();
              setState(() {});
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
