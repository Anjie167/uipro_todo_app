import 'package:flutter/material.dart';

class LinearProgress extends StatefulWidget {
  const LinearProgress({Key? key, required this.color,required this.value}) : super(key: key);
  final Color color;
  final double value;
  @override
  State<LinearProgress> createState() => _LinearProgressState();
}

class _LinearProgressState extends State<LinearProgress>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _animation = Tween(begin: 0.0, end: 0.01).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: _animation.value + widget.value.toDouble() /10,
      valueColor:
           AlwaysStoppedAnimation(widget.color),
      backgroundColor: Colors.purple[100],
    );
  }
}
