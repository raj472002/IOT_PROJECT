import 'dart:ffi';

import 'package:assgn/bedRoomPage.dart';
import 'package:assgn/cirlcles.dart';
import 'package:assgn/constants.dart';
import 'package:assgn/homeContainer.dart';
import 'package:assgn/notifiers.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _bedRoomController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));

    _bedRoomController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
    _bedRoomController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    var maxHeight = MediaQuery.of(context).size.height;
    return ListenableProvider.value(
      value: _animationController,
      child: ChangeNotifierProvider(
        create: (_) => Intensity(),
        child: ChangeNotifierProvider(
          create: (_) => BedRoomPageAnimationController(_bedRoomController),
          child: ChangeNotifierProvider(
            create: (_) => ColorNotifier(),
            child: Scaffold(
              backgroundColor: Constants.mainBlue,
              // floatingActionButton: FloatingActionButton(
              //   onPressed: () {
              //     _animationController.forward();
              //   },
              // ),
              bottomNavigationBar: BottomAppBar(
                elevation: 10,
                child: Row(
                  children: [
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset('assets/bulb.svg'),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        if (_animationController.status ==
                            AnimationStatus.completed && _bedRoomController.status == AnimationStatus.completed)  {
                              _bedRoomController.reverse();
                          _animationController.reverse();
                          
                        }
                      },
                      icon: SvgPicture.asset('assets/Icon feather-home.svg'),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset('assets/settingsIcon.svg'),
                    ),
                    Spacer()
                  ],
                ),
              ),
              body: SafeArea(
                child: Stack(
                  children: [
                    BackgroundCircles(),
                    AppBarContent(),
                    BedRoomTitle(),
                    MainContainer(),
                    LightLamp(),
                    TopListView(),
                    PowerButton()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MainContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    var maxHeight = MediaQuery.of(context).size.height;
    return Consumer<AnimationController>(
      builder: (_, controller, child) {
        double top;
        // if (controller.value == 0) {
        //   top = 180;
        // } else {
        //   top = 200.0 + controller.value * 80;
        // }
         top = 200.0 + controller.value * 80;
        return Container(
            padding: EdgeInsets.only(
              top: SizeConfig.screenHeight * 30 / 812,
              left: SizeConfig.screenWidth * 30 / 411,
              right: SizeConfig.screenWidth * 30 / 411,
              // bottom: SizeConfig.screenHeight * 30 / 812),
            ),
            // width: maxWidth,
            margin: EdgeInsets.only(
              top: top,
            ),
            decoration: BoxDecoration(
                color: Constants.containerWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: HomeContainerContent(),
                ),
                BedRoomContent(),
              ],
            ));
      },
    );
  }
}
