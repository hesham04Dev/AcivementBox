import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:localization_lite/translate.dart";


import "Bodies/HomeBody/homeBody.dart";
import "Bodies/giftsBody/giftsPage.dart";
import "Bodies/satisticBody/statisticBody.dart";
import "Bodies/settingBody/settingPage.dart";
import "Bodies/providers/pageIndexProvider.dart";
import "widget/BottomNavigationBar.dart";
import "widget/myFab.dart";



class HomePage extends StatefulWidget {
  const HomePage({super.key,this.title = "" });
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var bodiesController = context.read<PageIndexProvider>().bodiesController;

    List<Widget> bodies = [
      const SettingBody(),
      const HomeBody(),
      const GiftsBody(),
      const StatisticsBody()
    ];

    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title:  Text(
            widget.title.isEmpty ? tr("appName") : widget.title,
            
          ),
        ),
        body: PageView(
          onPageChanged: (index) {
            context.read<PageIndexProvider>().pageIndexChanged(index);
          },
          controller: bodiesController,
          children: bodies,
        ),
        floatingActionButton: const MyFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const MyBottomNavigationBar());
  }
}
