import 'package:flutter/material.dart';
import 'package:tabbar_theory/const/tabs.dart';

class AppbarUsingControllerScreen extends StatefulWidget {
  const AppbarUsingControllerScreen({super.key});

  @override
  State<AppbarUsingControllerScreen> createState() =>
      _AppbarUsingControllerScreenState();
}

class _AppbarUsingControllerScreenState
    extends State<AppbarUsingControllerScreen> with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: TABS.length,
      vsync: this,
    );

    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar Using Controller Screen'),
        bottom: TabBar(
          controller: tabController,
          tabs: TABS
              .map(
                (e) => Tab(
                  icon: Icon(e.icon),
                  child: Text(e.label),
                ),
              )
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: TABS
            .map(
              (e) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(e.icon),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (tabController.index != 0)
                        ElevatedButton(
                          onPressed: () {
                            tabController.animateTo(tabController.index - 1);
                          },
                          child: const Text('이전'),
                        ),
                      const SizedBox(width: 16),
                      if (tabController.index != TABS.length - 1)
                        ElevatedButton(
                          onPressed: () {
                            tabController.animateTo(tabController.index + 1);
                          },
                          child: const Text('다음'),
                        ),
                    ],
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
