import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:why_you_note/SCREENS/note_editor.dart';
import 'package:why_you_note/SCREENS/note_reader.dart';
import 'package:why_you_note/STYLE/app_style.dart';
import 'package:why_you_note/WIDGETS/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0.0,   
        title: Text('Notes App?'),
        centerTitle: true,
        backgroundColor: AppStyle.mainColor,
      ),


      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

        children: [
            Text('Your Recent Notes', style: GoogleFonts.roboto(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),



        SizedBox(
          height: 20.0,
        ),
        Expanded (
          child: StreamBuilder <QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('notes').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {        
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
             );
            }
              if (snapshot.hasData) {      
                  return GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
        
                  children: snapshot.data!.docs.map((note) => noteCard(() {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => NoteReaderScreen(note),));
                  }, note))
                  .toList(),
                   );
              }
        
                 return Text('There are not any notes', style: GoogleFonts.nunito(color: Colors.white));
            },
           
          ),
        ),
        
      ],
    ),
  ),
           
              floatingActionButton: FloatingActionButton.extended(
                onPressed: (){      
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NoteEditorScreen()));
                },
                label: Text('Add Note'),
                icon: Icon(Icons.add),
                ),

              
        );
    }
}
