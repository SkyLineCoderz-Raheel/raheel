import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = ScrollController();
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible) {
          setState(() {
            _isVisible = false;
          });
        }
      }

      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFB881D),
        leading: SvgPicture.asset("assets/Back.svg").paddingAll(15),
        title: _isVisible
            ? Text(
          "Detail",
          style: TextStyle(color: Colors.white),
        )
            : Text("Testing"),
        actions: [
          Icon(Icons.more_vert, color: Colors.white),
          if (!_isVisible)
            Hero(
              tag: 'heartIcon',
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: SvgPicture.asset("assets/heart.svg"),
              ),
            ),
        ],
        centerTitle: true,
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            pinned: false,
            primary: true,
            snap: true,
            floating: true,
            centerTitle: true,
            expandedHeight: 250,
            collapsedHeight: 200,
            flexibleSpace: Container(
              height: 250,
              child: Stack(
                children: [
                  Container(
                    height: 250,
                    width: Get.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/Mask Group.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  if (_isVisible)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      top: 180,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text("Testing"),
                          ],
                        ),
                      ),
                    ),
                  if (_isVisible)
                    Positioned(
                      top: 160,
                      right: 20,
                      child: Hero(
                        tag: 'heartIcon',

                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: SvgPicture.asset("assets/heart.svg"),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            backgroundColor: Colors.white,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
              childCount: 50,
            ),
          ),
        ],
      ),
    );
  }
}
