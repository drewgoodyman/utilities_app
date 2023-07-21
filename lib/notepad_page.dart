import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotepadPage extends StatefulWidget {
  @override
  _NotepadPageState createState() => _NotepadPageState();
}

class _NotepadPageState extends State<NotepadPage> {
  TextEditingController _textEditingController = TextEditingController();
  final String _noteKey = 'note';

  @override
  void initState() {
    super.initState();
    _loadNote();
  }

  void _loadNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String note = prefs.getString(_noteKey) ?? '';
    setState(() {
      _textEditingController.text = note;
    });
  }

  void _saveNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_noteKey, _textEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notepad')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _textEditingController,
                maxLines: null,
                decoration: InputDecoration(labelText: 'Write your notes here'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _saveNote();
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
