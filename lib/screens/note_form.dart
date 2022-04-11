import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteFormWidget extends StatelessWidget {
  final String? description;
  final String? category;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangedCategory;

  const NoteFormWidget(
      {Key? key, this.description = "", required this.onChangedDescription, this.category = "", required this.onChangedCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    
    return Container(
      width: width * 8,
      height: height * 0.49,
      margin: EdgeInsets.only(top: height * 0.3, left: width * 0.1),
      child: Column(
        children: [
          TextFormField(
            // initialValue: widget.note?.description,
            initialValue: description,
            onChanged: onChangedDescription,
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: 'Task Name',
              hintStyle: GoogleFonts.lato(
                  color: Colors.black.withOpacity(0.3), fontSize: 27),
            ),
            style: GoogleFonts.lato(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 27),
          ),
          SizedBox(height: height*0.05,),
          TextFormField(
            // initialValue: widget.note?.description,
            initialValue: category,
            onChanged: onChangedCategory,
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: 'category',
              hintStyle: GoogleFonts.lato(
                  color: Colors.black.withOpacity(0.3), fontSize: 27),
            ),
            style: GoogleFonts.lato(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 27),
          ),
        ],
      ),
    );
  }
}
