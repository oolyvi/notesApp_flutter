import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../STYLE/app_style.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({Key? key}) : super(key: key);

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  
  int color_id = Random().nextInt(AppStyle.cardsColor.length);

  String date = DateTime.now().toString();

  TextEditingController _tittleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],

      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),

        title: Text('Add a new note', style: TextStyle(color: Colors.black),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _tittleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Tittle',
              ),
              style: AppStyle.mainTittle,
            ),
              SizedBox(height: 8.0,),
              Text(date, style: AppStyle.dateTittle,),
              SizedBox(height: 28.0,),


            TextField(
              controller: _mainController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Content',
              ),
              style: AppStyle.mainContent,
            ),
          ]),
      ),
    
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () async {
          FirebaseFirestore.instance.collection('notes').add({
            'note_tiitle': _tittleController.text,
            'creation_date': date,
            'note_content': _mainController.text,
            'color_id' : color_id, 
          }).then((value) {
            print(value.id);
            Navigator.pop(context);
          }).catchError((error) => print('Failed to add new note due to $error')); 
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
