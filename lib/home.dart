import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return Scaffold(
                            appBar: AppBar(title: Text(notes[index].title)),
                            body: Center(child: Text(notes[index].content)),
                            floatingActionButton: FloatingActionButton(
                              child: const Icon(Icons.edit),
                              onPressed: () {},
                            ));
                      }));
                    },
                    title: Text(notes[index].title),
                    subtitle: Text(notes[index].content),
                  );
                })),
      ),
      floatingActionButton: FloatingActionButton(
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
                        keyboardType: TextInputType.multiline,
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
                  ),
                ),
              ),
            );
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
