import 'dart:convert';
import 'dart:io';

import 'package:notes/note.dart';

class Data {
  static List<Note> importData() {
    List<Note> notes = [];

    File file = File('notes.json');

    if (!file.existsSync()) {
      return notes;
    }

    String content = file.readAsStringSync();

    if (content.isEmpty) {
      return notes;
    }

    final decoded = jsonDecode(content) as List<dynamic>;

    for (var element in decoded) {
      Note note = Note.fromJson(element);
      notes.add(note);
    }

    return notes;
  }

  static void exportData(List<Note> notes) {
    File file = File('notes.json');

    if (!file.existsSync()) {
      File('notes.json').create();
    }

    // print(jsonEncode(notes));

    // String allNotes = '';

    // for (var i = 0; i < notes.length; i++) {
    //   allNotes += '{${notes[i].toString()}}';
    //   if (!(i == notes.length - 1)) {
    //     allNotes += ',';
    //   }
    // }

    file.writeAsStringSync(jsonEncode(notes));
  }
}
