import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:proxalarm/alarms_view.dart';
import 'package:proxalarm/constants.dart';
import 'package:proxalarm/map_view.dart';
import 'package:proxalarm/proxalarm_state.dart';

enum ProxalarmView { alarms, map }

class Home extends StatelessWidget {
  final pageController = PageController(initialPage: Get.find<ProxalarmState>().currentView.index);

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProxalarmState>(builder: (state) {
      return Scaffold(
        body: PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(), // Disable swipe gesture to change pages
            children: [
              AlarmsView(),
              MapView(),
            ]),
        extendBody: true,
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          child: NavigationBar(
              onDestinationSelected: (int index) {
                state.currentView = ProxalarmView.values[index];
                state.update();
                pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
              },
              selectedIndex: state.currentView.index,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.pin_drop_rounded),
                  label: 'Alarms',
                ),
                NavigationDestination(
                  icon: Icon(Icons.map_rounded),
                  label: 'Map',
                ),
              ]),
        ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: ExpandableFab(
          backgroundColor: paleBlue,
          child: Icon(Icons.keyboard_arrow_up_rounded),

          children: [
            FloatingActionButton.small(
              heroTag: null,
              child: const Icon(Icons.edit),
              onPressed: () {},
            ),
            FloatingActionButton.small(
              heroTag: null,
              child: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
      );
    });
  }

  // Widget getView(ProxalarmView v) {
  //   switch (v) {
  //     case ProxalarmView.alarms:
  //       return AlarmsView();
  //     case ProxalarmView.map:
  //       return MapView();
  //   }
  // }
}
