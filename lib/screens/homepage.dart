import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:page_transition/page_transition.dart';
import '../Animation/fade_animation.dart';
import '../data/shared preference/Task_saved.dart';
import '../data/tasks.dart';
import '../Animation/linearprogress.dart';
import '../data/time_say.dart';
import '../db/database.dart';
import '../model/note.dart';
import 'button_change_them.dart';
import 'card_tasks.dart';
import 'note_task.dart';

class HomePage extends StatefulWidget {
  final VoidCallback openDrawer;

  const HomePage({Key? key, required this.openDrawer}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> allSelectedTasks = []; // your tasks

  List<Note> notes = []; // get info from Database and add to this list

  bool isLoading = false;

  @override
  void initState() {
    allSelectedTasks = TaskerPreference.getString() ?? [];
    super.initState();
    refreshNote();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }

  Future refreshNote() async {
    setState(() => true);
    notes = await NotesDatabase.instance.readAllNotes();
    setState(() => false);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: widget.openDrawer,
                  icon: const Icon(
                    Icons.drag_handle_outlined,
                    color: Colors.grey,
                    size: 35,
                  )),
              SizedBox(
                width: width * 0.7,
              ),
              SizedBox(
                width: width * 0.01,
              ),
              const ChangeThemeButton()
            ],
          )
        ],
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [
            FadeAnimation(
              delay: 0.8,
              child: Container(
                margin: EdgeInsets.only(top: height * 0.02),
                width: width * 0.9,
                height: height * 0.15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TimeCall(),
                    SizedBox(
                      height: height * 0.06,
                    ),
                    Text(
                      "CATEGORIES",
                      style: TextStyle(
                          letterSpacing: 1,
                          color: Colors.grey.withOpacity(0.8),
                          fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            FadeAnimation(
              delay: 1,
              child: SizedBox(
                width: width * 2,
                height: height * 0.16,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, i) {
                    return Card(
                      margin: const EdgeInsets.only(left: 23),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      clipBehavior: Clip.antiAlias,
                      elevation: 2,
                      shadowColor: Colors.black.withOpacity(0.2),
                      child: Container(
                        width: width * 0.5,
                        height: height * 0.1,
                        margin: const EdgeInsets.only(
                          top: 25,
                          left: 14,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${categoryList[i].taskNumber} tasks",
                              style: TextStyle(
                                  color: Colors.grey.withOpacity(0.9)),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              categoryList[i].title,
                              style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: height * 0.03),
                            Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: LinearProgress(
                                  value: categoryList[i].value,
                                  color: categoryList[i].progressColor,
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryList.length,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 15, bottom: 15),
              child: Text(
                "TODAY'S TASKS",
                style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.grey.withOpacity(0.8),
                    fontSize: 13),
              ),
            ),
            FadeAnimation(
              delay: 1,
              child: SizedBox(
                width: width * 0.9,
                height: height * 0.4,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : notes.isEmpty
                        ? Container(
                            margin: const EdgeInsets.only(left: 130, top: 120),
                            child: Text("No Tasks",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor,
                                )))
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: notes.length,
                            itemBuilder: (context, index) {
                              int reverseIndex = notes.length - 1 - index;
                              final isSelected = allSelectedTasks.contains(notes[reverseIndex].description);
                              return Slidable(
                                  endActionPane: ActionPane(
                                    motion: const StretchMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) async {
                                          NotesDatabase.instance
                                              .delete(notes[reverseIndex].id!);
                                          refreshNote();
                                        },
                                        backgroundColor:
                                            const Color(0xFFFE4A49),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: "Delete",
                                      ),
                                      SlidableAction(
                                        onPressed: (context) async {
                                          await Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NoteTask(
                                                        note: notes[reverseIndex],
                                                      )));
                                          refreshNote();
                                        },
                                        backgroundColor:
                                            const Color(0xFF21B7CA),
                                        foregroundColor: Colors.white,
                                        label: "Edit",
                                        icon: Icons.edit,
                                      ),
                                    ],
                                  ),
                                  child: buildItem(
                                    notes[reverseIndex],
                                    isSelected,
                                    reverseIndex
                                  ));
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FadeAnimation(
        delay: 1.2,
        child: FloatingActionButton(
          onPressed: () async {
            await Navigator.of(context).push(PageTransition(
                type: PageTransitionType.fade, child: const NoteTask()));
            refreshNote();
          },
          backgroundColor: Theme.of(context).textTheme.headline1!.color,
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }

  Widget buildItem(Note item, isSelected, int i) {
    return CardTasks(
      category: notes[i].category,
      index: item.id!,
      onSelected: (tasks) async {
        setState(() {
          isSelected
              ? allSelectedTasks.remove(item.description)
              : allSelectedTasks.add(item.description);
        });
        TaskerPreference.setStringList(allSelectedTasks);
      },
      isActive: isSelected,
      taskUser: item,
    );
  }
}
