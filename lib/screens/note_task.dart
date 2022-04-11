import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uipro_todo_app/data/tasks.dart';
import '../Animation/fade_animation.dart';
import '../db/database.dart';
import '../model/note.dart';
import 'note_form.dart';

class NoteTask extends StatefulWidget {
  final Note? note;

  const NoteTask({Key? key, this.note}) : super(key: key);

  @override
  _NoteTaskState createState() => _NoteTaskState();
}

class _NoteTaskState extends State<NoteTask> {
  late String description;
  late String category;

  bool isOn = false;

  @override
  void initState() {
    super.initState();
    category = widget.note?.description ?? '';
    description = widget.note?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xffF4F6FD),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          child: Column(
            children: [
              FadeAnimation(
                delay: 0.2,
                child: Container(
                  margin:
                      EdgeInsets.only(top: height * 0.05, left: width * 0.73),
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.grey[300], shape: BoxShape.circle),
                  child: Container(
                      width: 47,
                      height: 47,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffF4F6FD),
                      ),
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 20,
                          ))),
                ),
              ),
              FadeAnimation(
                  delay: 0.3,
                  child: NoteFormWidget(
                    description: description,
                    category: category,
                    onChangedDescription: (description) {
                      setState(() => this.description = description);
                    },
                    onChangedCategory: (category) {
                      setState(() => this.category = category);
                    },
                  )),
              FadeAnimation(
                  delay: 0.4,
                  child: widget.note?.description == null
                      ? _buildButtonCreate(context)
                      : _buildButtonSave(context))
            ],
          ),
        ),
      ),
    );
  }

  void addTask(){
    addNote();
    for(int i = 0; i< categoryList.length; i++) {
      if (category == categoryList[i].title) {
        setState(() {
          categoryList[i].taskNumber++;
          categoryList[i].value = categoryList[i].value + 0.1;
        });
      }
    }
  }
  Widget _buildButtonCreate(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.4,
      height: 50,
      margin: EdgeInsets.only(left: width * 0.45),
      child: ElevatedButton(
          onPressed: addTask,
          style: ElevatedButton.styleFrom(
              primary: const Color(0xFF002FFF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "New task",
                style: GoogleFonts.lato(color: Colors.white),
              ),
              SizedBox(
                width: width * 0.03,
              ),
              const Icon(
                Icons.expand_less_outlined,
                color: Colors.white,
              )
            ],
          )),
    );
  }

  Widget _buildButtonSave(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.4,
      height: 50,
      margin: EdgeInsets.only(left: width * 0.45),
      child: ElevatedButton(
          onPressed: updateNote,
          style: ElevatedButton.styleFrom(
              primary: const Color(0xFF002FFF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Save",
                style: GoogleFonts.lato(color: Colors.white),
              ),
              SizedBox(
                width: width * 0.03,
              ),
              const Icon(
                Icons.edit,
                color: Colors.white,
              )
            ],
          )),
    );
  }

  Future addNote() async {
    final note = Note(description: description, category: category);
    if (description.isNotEmpty && category.isNotEmpty) {
      await NotesDatabase.instance.create(note);
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(description: description, category: category);
    await NotesDatabase.instance.update(note);
    isOn = true;
    Navigator.of(context).pop();
  }
}
