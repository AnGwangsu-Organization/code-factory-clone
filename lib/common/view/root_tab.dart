import 'package:code_factory_clone/common/const/colors.dart';
import 'package:code_factory_clone/common/layout/default_layout.dart';
import 'package:code_factory_clone/restaurant/view/restaurant_screen.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin{
  late TabController controller; // * controller가 선언이 되어 있다고 가정

  int index = 0;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 4, vsync: this);

    controller.addListener(tabListener);
  }

  // * 이벤트를 종료해줌
  @override
  void dispose() {
    super.dispose();

    controller.removeListener(tabListener);
  }

  // * currentIndex가 변동되도록
  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: '코팩 딜리버리',
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(), // * 스크롤로 화면이 이동되지 않도록
          controller: controller,
          children: [
            Center(
              child: Container(
                child: Text('홈'),
              ),
            ),
            Center(
              child: RestaurantScreen(),
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
            )
          ],
        ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          // 클릭한 탭의 숫자
          controller.animateTo(index);
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              label: '홈'
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.fastfood_outlined),
              label: '음식'
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.receipt_long_outlined),
              label: '주문'
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              label: '프로필'
          ),
        ],
      ),
    );
  }
}
