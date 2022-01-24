import 'package:flutter/material.dart';

import 'models/hotel_model.dart';

class AnimationContainerPage extends StatefulWidget {
  const AnimationContainerPage({Key? key}) : super(key: key);

  @override
  _AnimationContainerPageState createState() => _AnimationContainerPageState();
}

class _AnimationContainerPageState extends State<AnimationContainerPage> with TickerProviderStateMixin {

  List<Hotel> hotels = [
    Hotel(name: "Hotel 1", image: "assets/images/ic_hotel0.jpg"),
    Hotel(name: "Hotel 2", image: "assets/images/ic_hotel1.jpg"),
    Hotel(name: "Hotel 3", image: "assets/images/ic_hotel2.jpg"),
    Hotel(name: "Hotel 4", image: "assets/images/ic_hotel3.jpg"),
    Hotel(name: "Hotel 5", image: "assets/images/ic_hotel4.jpg"),
  ];

  int index = 0;
  String image = "assets/images/ic_header.jpg";

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _animation,
                child: AnimatedContainer(
                  height: 200,
                  width: 200,
                  duration: const Duration(seconds: 2),
                  curve: Curves.easeIn,
                  color: Colors.white.withOpacity(0),
                  // child: Image.asset(image),
                  foregroundDecoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(image),
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(100, 40),
                ),
                onPressed: () {
                  index = index % 4 + 1;
                  setState(() {
                    image = hotels[index].image;
                  });
                },
                child: const Text(
                  "Animate",
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
