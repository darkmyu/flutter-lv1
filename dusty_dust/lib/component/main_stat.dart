import 'package:dusty_dust/const/status_level.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/utils/date_utils.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class MainStat extends StatelessWidget {
  final Region region;

  const MainStat({
    super.key,
    required this.region,
  });

  @override
  Widget build(BuildContext context) {
    const ts = TextStyle(
      color: Colors.white,
      fontSize: 40.0,
    );

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: FutureBuilder<StatModel?>(
            future: GetIt.I<Isar>()
                .statModels
                .filter()
                .regionEqualTo(region)
                .itemCodeEqualTo(ItemCode.PM10)
                .sortByDateTimeDesc()
                .findFirst(),
            builder: (context, snapshot) {
              if (!snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (!snapshot.hasData) {
                return const Center(
                  child: Text('데이터가 없습니다.'),
                );
              }

              final statModel = snapshot.data!;

              final index = statusLevels.indexWhere(
                (e) => statModel.stat < e.minPM10,
              );

              if (index < 0) {
                return const Center(
                  child: Text('통계 수치에 에러가 있습니다.'),
                );
              }

              final status = statusLevels[index - 1];

              return Column(
                children: [
                  Text(
                    '서울',
                    style: ts.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    DateUtils.DateTimeToString(
                      dateTime: statModel.dateTime,
                    ),
                    style: ts.copyWith(
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Image.asset(
                    status.imagePath,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    status.label,
                    style: ts.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    status.comment,
                    style: ts.copyWith(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
