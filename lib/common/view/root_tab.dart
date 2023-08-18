import 'package:flutter/material.dart';
import 'package:flutter_edu_app/common/const/colors.dart';
import 'package:flutter_edu_app/common/layout/default_layout.dart';

import '../../restaurant/view/restaurant_screen.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  //나중에 입력하는 값일 때 미리 선언
  late TabController tabController;
  int index = 0;

  @override
  void initState() {
    super.initState();
    //vsync rendering engine this가 기능을 가져야함(SingleTickerProviderStateMixin)
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(tabListener);
  }

  @override
  void dispose() {
    tabController.removeListener(tabListener);

    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'test TEst',
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          RestaurantScreen(),
          Center(
            child: Container(
              child: Text('음식'),
            ),
          ),
          Center(
            child: Container(
              child: Text('주문'),
            ),
          ),
          Center(
            child: Container(
              child: Text('프로필'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          tabController.animateTo(index);
        },
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label:'홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label:'음식',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label:'주문',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label:'프로필',
          )
        ],
      ),
    );
  }
}
