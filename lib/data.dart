import 'dart:convert';
import 'dart:io';

import 'package:notes/note.dart';

class Data {
  List<Note> importData() {
    List<Note> notes = [];

    File file = File('notes.json');
    String content = file.readAsStringSync();
    final decoded = jsonDecode(content) as List<dynamic>;

    for (var element in decoded) {
      Note note = Note.fromJSON(element);
      notes.add(note);
    }

    return notes;
  }

  void exportData(List<Note> notes) {
    File('notes.json').writeAsStringSync(jsonEncode(notes));
  }
}
