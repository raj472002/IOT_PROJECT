import 'package:assgn/constants.dart';
import 'package:assgn/notifiers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class BedRoomTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AnimationController, BedRoomPageAnimationController>(
        builder: (context, controller, bedRoomController, child) {
      if (controller.status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 700)).then((value) {
          bedRoomController.forward();
        });
      }
      
      double translate = -30 + bedRoomController.value * 30;

      return Positioned(
          left: SizeConfig.screenWidth * 20 / 411,
          top: SizeConfig.screenHeight * 40 / 812,
          child: Opacity(
            opacity: math.max(0, 2 * controller.value - 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (controller.status == AnimationStatus.completed &&
                            bedRoomController.controller.status ==
                                AnimationStatus.completed) {
                          bedRoomController.reverse();
                          controller.reverse();
                        }
                      },
                      child: Padding(
                          padding: EdgeInsets.only(
                            right: 15,
                          ),
                          child: SvgPicture.asset(
                              'assets/Icon ionic-md-arrow-round-back.svg')),
                    ),
                    Text(
                      'Bed',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: SizeConfig.screenWidth * 28 / 411,
                      ),
                    )
                  ],
                ),
                Text(
                  'Room',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: SizeConfig.screenWidth * 28 / 411,
                  ),
                ),
                Opacity(
                  opacity: bedRoomController.value,
                  child: Transform.translate(
                    offset: Offset(0, translate),
                    child: Container(
                        margin: EdgeInsets.only(
                          top: SizeConfig.screenHeight * 15 / 812,
                        ),
                        child: Text(
                          '4 Lights',
                          style: TextStyle(
                            color: Constants.mainYello,
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig.screenWidth * 16 / 411,
                          ),
                        )),
                  ),
                )
              ],
            ),
          ));
    });
  }
}

class LightLamp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer4<AnimationController, BedRoomPageAnimationController,
            ColorNotifier, Intensity>(
        builder: (context, controller, bedroomcontroller, colorNotifer,
            intensityNotifer, child) {
      double top;
      // if (controller.status == AnimationStatus.completed) {
      //   Future.delayed(Duration(milliseconds: 1000)).then((value) {
      //     bedroomcontroller.forward();
      //   });
      // }
      top = -30 + bedroomcontroller.value * 30;
      // top = -30;
      return Container(
        // color: Colors.red,
        height: 400,

        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                right: 30,
                top: top,
                child: Opacity(
                  opacity: math.max(0, 2 * controller.value - 1),
                  child: Column(
                    children: [
                      // Container(
                      //   height: 10,
                      //   width: 5,
                      //   color: Colors.white,
                      // ),
                      SvgPicture.asset('assets/Group 38.svg'),
                      Container(
                        height: 10,
                        width: 20,
                        decoration: BoxDecoration(
                            color: intensityNotifer.value == 0
                                ? Colors.black45
                                : colorNotifer.color.withOpacity(
                                    2 * intensityNotifer.value / 10),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 2),
                                  color: colorNotifer.color
                                      .withOpacity(intensityNotifer.value / 10),
                                  spreadRadius: 4,
                                  blurRadius: 8)
                            ]),
                      ),
                    ],
                  ),
                )),
            Positioned(
                top: 0,
                bottom: SizeConfig.screenHeight - top,
                right: SizeConfig.screenWidth * 97 / 411,
                child: Opacity(
                  opacity: controller.value,
                  child: Container(
                    height: 20,
                    width: 5,
                    color: Colors.red,
                  ),
                ))
          ],
        ),
      );
    });
  }
}

class TopListView extends StatelessWidget {
  List<TopListViewModel> _topListView = [
    TopListViewModel('Main Light', 'assets/solution.svg'),
    TopListViewModel('Desk Lights', 'assets/furniture-and-household.svg'),
    TopListViewModel('Bed Light', 'assets/bed (1).svg'),
  ];

  int _isSelectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer2<AnimationController, BedRoomPageAnimationController>(
        builder: (_, controller, bedRoomController, child) {
      double top = SizeConfig.screenHeight * 180 / 812;

      // if (controller.status == AnimationStatus.completed) {
      //   Future.delayed(Duration(milliseconds: 1000)).then((value) {
      //     bedRoomController.forward();
      //   });
      // }
      double leftPos =
          math.max(0, SizeConfig.screenWidth * (1 - bedRoomController.value));
      // double opaicity = 2 - 0.8 * bedRoomController.value ;
      return Positioned(
          top: top,
          // bottom: 0,
          left: leftPos,
          right: 0,
          // top: 180,
          child: Opacity(
            opacity: controller.value,
            child: Opacity(
              opacity: bedRoomController.value,
              child: Container(
                height: SizeConfig.screenHeight * 47 / 812,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: _topListView.length,
                    itemBuilder: (_, index) {
                      return Container(
                        margin:
                            EdgeInsets.only(left: index == 0 ? 20 : 0, right: 20),
                        child: MaterialButton(
                          minWidth: 80,
                          elevation: _isSelectedIndex == index ? 2 : 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: _isSelectedIndex == index
                              ? Constants.darkBlue.withOpacity(0.2)
                              : Colors.white,
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          onPressed: () {},
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                _topListView[index].icon,
                                color: _isSelectedIndex != index
                                    ? Constants.darkBlue
                                    : Colors.white,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: SizeConfig.screenWidth * 10 / 411),
                                child: Text(
                                  _topListView[index].title,
                                  style: TextStyle(
                                    color: _isSelectedIndex != index
                                        ? Constants.darkBlue
                                        : Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                      // return Container(
                      //   width: 50,
                      //   height: 50,
                      //   color: Colors.white,
                      // );
                    }),
              ),
            ),
          ));
    });
  }
}

class BedRoomContent extends StatelessWidget {
  List<SceneModel> _scenes = [
    SceneModel('Birthday', [Color(0xffff9e9a), Color(0xffffb493)]),
    SceneModel('Party', [Color(0xffab93eb), Color(0xffd293eb)]),
    SceneModel('Relax', [Color(0xff93cceb), Color(0xff93d9eb)]),
    SceneModel('Fun', [Color(0xff8fdf94), Color(0xffb5e992)]),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer3<AnimationController, Intensity,
            BedRoomPageAnimationController>(
        builder: (context, controller, intensity, bedRoomController, child) {
      // if (controller.status == AnimationStatus.completed) {
      //   Future.delayed(Duration(milliseconds: 1000)).then((value) {
      //     bedRoomController.forward();
      //   });
      // }
      return Opacity(
        opacity: math.max(0, 2 * controller.value - 1),
        child: Container(
          // padding: EdgeInsets.symmetric(
          //   vertical: SizeConfig.screenHeight * 30 / 812,
          //   horizontal: SizeConfig.screenWidth * 30 / 411,
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Intensity',
                style: TextStyle(
                  color: Constants.darkBlue,
                  fontSize: SizeConfig.screenWidth * 20 / 411,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.screenHeight * 10 / 812,
                  bottom: SizeConfig.screenHeight * 20 / 812,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/solution2.svg'),
                    // Spacer(),
                    Expanded(
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Constants.mainYello,
                          inactiveTrackColor: Colors.grey.shade300,
                          trackShape: RectangularSliderTrackShape(),
                          trackHeight: 2.0,
                          thumbColor: Colors.white,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 12.0),
                          overlayColor: Colors.red.withAlpha(32),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 28.0),
                        ),
                        child: Container(
                          // width: 300,
                          child: Slider(
                            label: intensity.value.toString(),
                            min: 0,
                            max: 5,
                            divisions: 5,
                            value: intensity.value,
                            onChanged: (value) {
                              intensity.setValue(value);
                            },
                          ),
                        ),
                      ),
                    ),
                    // Spacer(),
                    SvgPicture.asset('assets/solution.svg'),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: SizeConfig.screenHeight * 20 / 812,
                ),
                child: Text(
                  'Colors',
                  style: TextStyle(
                    color: Constants.darkBlue,
                    fontSize: SizeConfig.screenWidth * 20 / 411,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              ColorList(),
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                ),
                child: Text(
                  'Scenes',
                  style: TextStyle(
                    color: Constants.darkBlue,
                    fontSize: SizeConfig.screenWidth * 20 / 411,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.screenHeight * 20 / 812,
                ),
                child: Scenes(),
              )
            ],
          ),
        ),
      );
    });
  }
}

class ColorList extends StatelessWidget {
  List<Color> _colorsList = [
    Color(0xffff9b9b),
    Color(0xff94eb9e),
    Color(0xff94caeb),
    Color(0xffa594eb),
    Color(0xffde94eb),
    Color(0xffebd094),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer3<AnimationController, BedRoomPageAnimationController,
            ColorNotifier>(
        builder: (_, controller, bedroomController, ColorNotifier, child) {
      // if (controller.status == AnimationStatus.completed) {
      //   Future.delayed(Duration(milliseconds: 1000)).then((value) {
      //     bedroomController.forward();
      //   });
      // }

      double rightMargin = bedroomController.value * 15;

      return Container(
        height: SizeConfig.screenHeight * 40 / 812,
        child: Row(
          // innerDistance:  10,

          children: [
            ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _colorsList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: rightMargin),
                    child: GestureDetector(
                      onTap: () {
                        ColorNotifier.setBulbColor(_colorsList[index]);
                      },
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: _colorsList[index],
                      ),
                    ),
                  );
                }),
            GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white,
                child: SvgPicture.asset('assets/+.svg'),
              ),
            )
          ],
        ),
      );
    });
  }
}

class PowerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<AnimationController>(
      builder: (_, controller, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                right: SizeConfig.screenWidth * 30 / 411,
                // top: SizeConfig.screenHeight * 250 / 812,
                child: Opacity(
                  opacity: math.max(0, 2 * controller.value - 1),
                  child: Container(
                    width: 35,
                    height: 35,
                    // padding: EdgeInsets.only(
                    //   bottom: 50
                    // ),
                    margin: EdgeInsets.only(
                      bottom: SizeConfig.screenHeight * 235 / 812,
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 20,
                        width: 20,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 2)
                            ]),
                        child: SvgPicture.asset(
                            'assets/Icon awesome-power-off.svg'),
                      ),
                    ),
                  ),
                ))
          ],
        );
      },
    );
  }
}

class Scenes extends StatelessWidget {
  List<SceneModel> _scenes = [
    SceneModel('Birthday', [Color(0xffff9e9a), Color(0xffffb493)]),
    SceneModel('Party', [Color(0xffab93eb), Color(0xffd293eb)]),
    SceneModel('Relax', [Color(0xff93cceb), Color(0xff93d9eb)]),
    SceneModel('Fun', [Color(0xff8fdf94), Color(0xffb5e992)]),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer2<AnimationController, BedRoomPageAnimationController>(
      builder: (_, controller, bedRoomController, child) {
        //    if (controller.status == AnimationStatus.completed) {
        //   Future.delayed(Duration(milliseconds: 1000)).then((value) {
        //     bedRoomController.forward();
        //   });
        // }
        return Container(
          // color: Colors.red,
          height: SizeConfig.screenHeight * 150 / 812,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                child: Container(
                  child: Column(
                    children: [
                      _sceneWidget(_scenes[0].title, _scenes[0].colorData),
                      SizedBox(
                        height: 20,
                      ),
                      _sceneWidget(_scenes[2].title, _scenes[2].colorData),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 55 * (1 - bedRoomController.value),
                child: Container(
                  child: Column(
                    children: [
                      _sceneWidget(_scenes[1].title, _scenes[1].colorData),
                      SizedBox(
                        height: 20,
                      ),
                      _sceneWidget(_scenes[3].title, _scenes[3].colorData),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sceneWidget(String title, List<Color> color) {
    return Container(
      height: SizeConfig.screenHeight * 60 / 812,
      width: SizeConfig.screenWidth * 165 / 411,
      child: AspectRatio(
        aspectRatio: 1.5,
        child: Container(
          //  height: 50,
          //  width: 200,
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * 20 / 411,
            vertical: SizeConfig.screenHeight * 10 / 812,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: color,
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(
                'assets/surface1.svg',
                color: Colors.white,
              ),
              // Spacer(),
              Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
