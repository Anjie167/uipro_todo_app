import 'package:flutter/material.dart';

import '../data/tasks.dart';
import '../model/note.dart';

class CardTasks extends StatefulWidget {
  Note taskUser;
  bool isActive;
  String? category;
  int index;
  ValueChanged<Note> onSelected;

  CardTasks(
      {Key? key,
      required this.taskUser,
      required this.isActive,
      required this.index,
      required this.category,
      required this.onSelected})
      : super(key: key);

  @override
  State<CardTasks> createState() => _CardTasksState();
}

class _CardTasksState extends State<CardTasks> {
  final colorIcon = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.orange
  ];

  Color getColor(String category) {
    Color cardColour = Colors.white;
    for (int i = 0; i < categoryList.length; i++) {
      if (category == categoryList[i].title) {
        cardColour = categoryList[i].progressColor;
      }
    }
    return cardColour;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: width * 0.9,
        height: height * 0.09,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child: InkWell(
                  onTap: () => widget.onSelected(widget.taskUser),
                  child: widget.isActive
                      ? const Icon(Icons.check_circle_outlined,
                          color: Colors.grey)
                      : Icon(
                          Icons.circle_outlined,
                          color: getColor(widget.category!),
                        ),
                )),
            SizedBox(
              width: width * 0.025,
            ),
            Expanded(
                child: Text(widget.taskUser.description,
                    maxLines: 20,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                      // ignore: unrelated_type_equality_checks
                      decoration: widget.isActive
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    )))
          ],
        ),
      ),
    );
  }
}
