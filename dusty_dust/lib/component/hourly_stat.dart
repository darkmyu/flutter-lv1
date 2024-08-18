import 'package:dusty_dust/const/colors.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/utils/status_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class HourlyStat extends StatelessWidget {
  final Region region;

  const HourlyStat({
    super.key,
    required this.region,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ItemCode.values
          .map(
            (itemCode) => FutureBuilder<List<StatModel>>(
              future: GetIt.I<Isar>()
                  .statModels
                  .filter()
                  .regionEqualTo(region)
                  .itemCodeEqualTo(itemCode)
                  .sortByDateTimeDesc()
                  .limit(24)
                  .findAll(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                final stats = snapshot.data!;

                return SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Card(
                      color: lightColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: darkColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16.0),
                                topLeft: Radius.circular(16.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                              ),
                              child: Text(
                                '시간별 ${itemCode.krName}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          ...stats.map(
                            (stat) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 4.0,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${stat.dateTime.hour.toString().padLeft(2, '0')}시',
                                    ),
                                  ),
                                  Expanded(
                                    child: Image.asset(
                                      StatusUtils.getStatusModelFromStat(
                                        statModel: stat,
                                      ).imagePath,
                                      height: 20.0,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      StatusUtils.getStatusModelFromStat(
                                        statModel: stat,
                                      ).label,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
          .toList(),
    );
  }
}
