import 'package:dusty_dust/component/category_stat.dart';
import 'package:dusty_dust/component/hourly_stat.dart';
import 'package:dusty_dust/component/main_stat.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/repository/stat_repository.dart';
import 'package:dusty_dust/utils/status_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Region region = Region.seoul;

  @override
  void initState() {
    super.initState();

    StatRepository.fetchData();
    getCount();
  }

  getCount() async {
    print(await GetIt.I<Isar>().statModels.count());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StatModel?>(
        future: GetIt.I<Isar>()
            .statModels
            .filter()
            .regionEqualTo(region)
            .itemCodeEqualTo(ItemCode.PM10)
            .sortByDateTimeDesc()
            .findFirst(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: CircularProgressIndicator(),
            );
          }

          final statModel = snapshot.data!;
          final statusModel = StatusUtils.getStatusModelFromStat(
            statModel: statModel,
          );

          return Scaffold(
            backgroundColor: statusModel.primaryColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  MainStat(
                    region: region,
                  ),
                  CategoryStat(
                    region: region,
                    darkColor: statusModel.darkColor,
                    lightColor: statusModel.lightColor,
                  ),
                  HourlyStat(
                    region: region,
                    darkColor: statusModel.darkColor,
                    lightColor: statusModel.lightColor,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
