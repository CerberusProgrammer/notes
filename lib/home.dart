import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data.dart';
import 'note.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController contentEditingController = TextEditingController();
  List<Note> notes = [];

  void createNote(String title, String content) {
    Note note = Note(title, content);

    setState(() {
      notes.add(note);
    });
  }

  FloatingActionButton edit(
      int index, String title, String content, BuildContext main) {
    return FloatingActionButton(
      tooltip: 'Edit',
      child: const Icon(Icons.edit),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          TextEditingController titleEditingController =
              TextEditingController();
          TextEditingController contentEditingController =
              TextEditingController();
          titleEditingController.text = title;
          contentEditingController.text = content;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Edit'),
            ),
            body: Center(
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: titleEditingController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Title',
                          ),
                        ),
                        TextField(
                          controller: contentEditingController,
                          autofocus: true,
                          minLines: 10,
                          maxLines: 20,
                          maxLength: 1000,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color:
                                          Color.fromARGB(255, 116, 116, 116)))),
                        ),
                      ],
                    ))),
            floatingActionButton: FloatingActionButton(
              tooltip: 'Confirm',
              child: const Icon(Icons.check),
              onPressed: () {
                setState(() {
                  notes[index].title = titleEditingController.text;
                  notes[index].content = contentEditingController.text;
                });

                Data.exportData(notes);
                Navigator.pop(context);
                Navigator.pop(main);
              },
            ),
          );
        }));
      },
    );
  }

  IconButton remove(int index) {
    return IconButton(
      tooltip: 'Remove',
      icon: const Icon(Icons.delete_outline_rounded),
      onPressed: () {
        setState(() {
          notes.removeAt(index);
        });

        Data.exportData(notes);
        Navigator.pop(context);
      },
    );
  }

  FloatingActionButton add() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                String content = contentEditingController.text;

                if (content.isNotEmpty) {
                  String title = titleEditingController.text;
                  createNote(title, content);
                }

                titleEditingController.clear();
                contentEditingController.clear();

                Data.exportData(notes);
                Navigator.pop(context);
              },
              child: const Icon(Icons.check),
            ),
            appBar: AppBar(
              title: const Text('Create'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleEditingController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Title',
                      ),
                    ),
                    TextField(
                      controller: contentEditingController,
                      autofocus: true,
                      minLines: 10,
                      maxLines: 20,
                      maxLength: 1000,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 116, 116, 116)))),
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
      },
      child: const Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    notes = Data.importData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(5),
          child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return Scaffold(
                        appBar: AppBar(
                          title: Text(notes[index].title),
                          actions: [
                            IconButton(
                              tooltip: 'Copy',
                              onPressed: () {
                                String text = notes[index].content;
                                Clipboard.setData(ClipboardData(text: text))
                                    .then((value) =>
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: const Text('Copied'),
                                          action: SnackBarAction(
                                              label: 'Close', onPressed: () {}),
                                        )));
                              },
                              icon: const Icon(Icons.copy),
                            ),
                            remove(index),
                          ],
                        ),
                        body: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(notes[index].content),
                        )),
                        floatingActionButton: edit(index, notes[index].title,
                            notes[index].content, context),
                      );
                    }));
                  },
                  title: Text(notes[index].title),
                  subtitle: Text(notes[index].content),
                ));
              })),
      floatingActionButton: add(),
    );
  }
}
