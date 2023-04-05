import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgets/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _HomePageState();
}

class _HomePageState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 4000),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 2 * pi,
    ).animate(_controller);

    _controller.forward().then((value) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => MyApp()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 222, 220, 220),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateY(
                  _animation.value,
                ),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/logo.png'), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.5),
                  //     spreadRadius: 2,
                  //     blurRadius: 3,
                  //     offset: const Offset(0, 3),
                  //   ),
                  // ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
