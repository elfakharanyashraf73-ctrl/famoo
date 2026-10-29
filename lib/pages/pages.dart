import 'package:flutter/material.dart';
import 'package:famoo/pages/favortepage.dart';
import 'package:famoo/pages/homepage.dart';
import 'package:famoo/pages/settingpage.dart';

class Pages extends StatefulWidget {
  const Pages({super.key});

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  int index = 0;
  List<Widget> list = [Homepage(), Favpage(), Setpage()];

  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (int newIndex) {
          setState(() {
            index = newIndex;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorite'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body: list[index],
    );
  }
}
