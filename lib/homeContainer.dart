import 'package:assgn/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;


class AppBarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<AnimationController>(
      builder: (context, controller, child) {
        return Positioned(
            top: SizeConfig.screenHeight * 58 / 812,
            child: Opacity(
              opacity: math.max(0, 1 - 2 * controller.value),
              child: Container(
                width: SizeConfig.screenWidth - 40,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: child,
              ),
            ));
      },
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Control',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.screenWidth * 30 / 411,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Panel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.screenWidth * 30 / 411,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Spacer(),
          CircleAvatar(
            radius: 40,
            child: SvgPicture.asset(
              'assets/user.svg',
            ),
          )
        ],
      ),
    );
  }
}

class HomeContainerContent extends StatelessWidget {
  List<HomeViewModel> _list = [
    HomeViewModel('Bed room', '4 lights', SvgPicture.asset('assets/bed.svg')),
    HomeViewModel(
        'Living Room', '2 lights', SvgPicture.asset('assets/room.svg')),
    HomeViewModel(
        'Kitchen', '5 lights', SvgPicture.asset('assets/kitchen.svg')),
    HomeViewModel(
        'Bathroom', '1 lights', SvgPicture.asset('assets/bathtube.svg')),
    HomeViewModel('Outdoor', '5 lights', SvgPicture.asset('assets/house.svg')),
    HomeViewModel(
        'Balcony', '2 lights', SvgPicture.asset('assets/balcony.svg')),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<AnimationController>(
      builder: (context, controller, child) {
        return Opacity(
          opacity: math.max(0, 1 - 2 * controller.value),
          child: Container(
            // padding: EdgeInsets.only(
            //   top: SizeConfig.screenHeight * 30 / 812,
            //   left: SizeConfig.screenWidth * 30 / 411,
            //   right:  SizeConfig.screenWidth * 30 / 411
            // ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'All Rooms',
                  style: TextStyle(
                    color: Constants.darkBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.screenWidth * 18 / 411,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GridView.builder(
                  
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                    
                      mainAxisSpacing: 15,
                    ),
                    itemCount: _list.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          controller.forward();
                        },
                        child: Card(
                            shadowColor: Colors.black.withOpacity(0.2),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: SizeConfig.screenHeight * 20 / 812,
                                  bottom: SizeConfig.screenHeight * 10 / 812,
                                  left: SizeConfig.screenWidth * 20 / 411,
                                  right: SizeConfig.screenWidth * 30 / 812),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _list[index].icon,
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: SizeConfig.screenHeight * 20 / 812,
                                      bottom:
                                          SizeConfig.screenHeight * 10 / 812,
                                    ),
                                    child: Text(
                                      _list[index].title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            SizeConfig.screenWidth * 16 / 411,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    _list[index].lights,
                                    style: TextStyle(
                                      color: Colors.orangeAccent,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            )),
                      );
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
