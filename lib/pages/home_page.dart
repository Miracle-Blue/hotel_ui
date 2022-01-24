import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hotel_ui/models/hotel_model.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String id = "/home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  bool isLoad = false;
  int randomIndex = 0;

  String iMage = "assets/images/ic_header.jpg";

  List<Hotel> hotels = [
    Hotel(name: "Hotel 1", image: "assets/images/ic_hotel0.jpg"),
    Hotel(name: "Hotel 2", image: "assets/images/ic_hotel1.jpg"),
    Hotel(name: "Hotel 3", image: "assets/images/ic_hotel2.jpg"),
    Hotel(name: "Hotel 4", image: "assets/images/ic_hotel3.jpg"),
    Hotel(name: "Hotel 5", image: "assets/images/ic_hotel4.jpg"),
  ];

  Future loadData() async {
    setState(() {
      isLoad = true;
    });

    await Future.delayed(const Duration(seconds: 5));

    setState(() {
      isLoad = false;
    });
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat(reverse: true)..addStatusListener((status) {if (status == AnimationStatus.forward) {
    setState(() {
      randomIndex = randomIndex % 4 + 1;
      iMage = hotels[randomIndex].image;
    });
  }
  });
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        /// header
        header(context),

        /// body
        isLoad
            ? Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < 3; i++) hotelsFieldInShimmer(),
                  ],
                ),
              )
            : Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    hotelsField(title: "Business Hotels", listOfHotels: hotels),
                    hotelsField(title: "Business Hotels", listOfHotels: hotels),
                    hotelsField(title: "Business Hotels", listOfHotels: hotels),
                    hotelsField(title: "Business Hotels", listOfHotels: hotels),
                  ],
                ),
              ),
      ],
    ));
  }

  Widget hotelsFieldInShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.grey.shade200,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10)),
            height: 20,
            width: 180,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) => Container(
              width: 160,
              margin: const EdgeInsets.only(right: 20),
              child: Shimmer.fromColors(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20)),
                ),
                baseColor: Colors.grey.shade400,
                highlightColor: Colors.grey.shade200,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Column hotelsField({required String title, required List listOfHotels}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Business Hotels",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 180,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: listOfHotels.map((e) => hotelsList(e)).toList(),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Container hotelsList(Hotel e) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(e.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black54,
              Colors.black12,
            ],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              e.name,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            IconButton(
              padding: const EdgeInsets.all(0),
              alignment: Alignment.bottomCenter,
              onPressed: () {
                setState(() {
                  e.isLike = !e.isLike;
                });
              },
              icon: e.isLike
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    return Stack(
      children: [
        FadeTransition(
          opacity: _animation,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(iMage),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black87,
                Colors.black54,
                Colors.black12,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Best Hotels Ever",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: TextFormField(
                  style: const TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search for hotels...",
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
