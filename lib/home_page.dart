// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsheets_project/google_heets_api.dart';
import 'package:gsheets_project/loader.dart';
import 'notes_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

@override
class _HomePageState extends State<HomePage> {
  final TextEditingController _noteController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _noteController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _noteController.addListener(() => setState(() {}));
  }

  // wait for the data to be fetch from google sheets api
  void startLoading() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.isLoading == false) {
        setState(() {
          timer.cancel();
        });
      }
    });
  }

  void saveNote() {
    if (_noteController.text != '') {
      GoogleSheetsApi.insertNote(_noteController.text);
      _noteController.clear();
    } else if (_noteController.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 3),
          content: const Text(
            'Must write something!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // start loading until the data arrives
    if (GoogleSheetsApi.isLoading == true) {
      startLoading();
    }

    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            'G.Sheets Notes',
            style: TextStyle(
                color: Colors.grey[800],
                letterSpacing: 5,
                wordSpacing: 6,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.center,
              image: AssetImage('assets/bg.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: GoogleSheetsApi.isLoading == true
                        ? const Loader()
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.0, vertical: 5),
                            child: NotesGrid(),
                          ),
                  ),
                ],
              ),
              //
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: FloatingActionButton(
                    backgroundColor: Colors.yellow[200],
                    onPressed: () => _showAddNoteDialog(context),
                    child: Icon(
                      color: Colors.black54,
                      Icons.add,
                      size: 32,
                    ),
                  ),
                ),
              ),
              //
              Positioned(
                bottom: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5, left: 10),
                  child: Text(
                    'by Valentin E.',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  //
  // This shows a dialog box for SAVE A NEW NOTES option.
  _showAddNoteDialog(BuildContext context) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: CupertinoTextField(
            maxLength: 50,
            controller: _noteController,
            placeholder: 'Enter note ...',
            suffix: CupertinoButton(
              child: const Icon(
                Icons.clear,
                color: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  _noteController.clear();
                });
              },
            ),
            onSubmitted: (value) => {
              saveNote(),
              Navigator.of(context).pop(),
            },
          ),
          actions: <Widget>[
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
              onPressed: () {
                saveNote();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
