import 'package:dusty_dust/component/category_stat.dart';
import 'package:dusty_dust/component/hourly_stat.dart';
import 'package:dusty_dust/component/main_stat.dart';
import 'package:dusty_dust/const/colors.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/repository/stat_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: FutureBuilder<List<StatModel>>(
          future: StatRepository.fetchData(
            itemCode: ItemCode.PM10,
          ),
          builder: (context, snapshot) {
            print(snapshot.error);
            print(snapshot.stackTrace);
            print(snapshot.data);
            return const Column(
              children: [
                MainStat(),
                CategoryStat(),
                HourlyStat(),
              ],
            );
          },
        ),
      ),
    );
  }
}
