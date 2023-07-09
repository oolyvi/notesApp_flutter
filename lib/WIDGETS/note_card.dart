import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:why_you_note/STYLE/app_style.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppStyle.cardsColor[doc['color_id']],
        borderRadius: BorderRadius.circular(8.0),        
      ),

//her bir card icindeki yazinin dekorasiyasini edirik, Firebase icerisindeki
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(doc['note_tiitle'], style: AppStyle.mainTittle,),

          SizedBox(height: 4.0,),

          Text(doc['creation_date'], style: AppStyle.dateTittle,),

          SizedBox(height: 8.0,),

          Text(doc['note_content'], style: AppStyle.mainContent, overflow: TextOverflow.ellipsis,),
        ],
      ),
    ),
  );
}