import 'package:dusty_dust/const/colors.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/utils/status_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class CategoryStat extends StatelessWidget {
  final Region region;

  const CategoryStat({
    super.key,
    required this.region,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 160,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              16.0,
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraint) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: darkColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        '종류별 통계',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: lightColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0),
                        ),
                      ),
                      child: ListView(
                        physics: const PageScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: ItemCode.values
                            .map(
                              (itemCode) => FutureBuilder(
                                future: GetIt.I<Isar>()
                                    .statModels
                                    .filter()
                                    .regionEqualTo(region)
                                    .itemCodeEqualTo(itemCode)
                                    .sortByDateTimeDesc()
                                    .findFirst(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Container();
                                  }

                                  final statModel = snapshot.data!;
                                  final statusModel =
                                      StatusUtils.getStatusModelFromStat(
                                    statModel: statModel,
                                  );

                                  return SizedBox(
                                    width: constraint.maxWidth / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(itemCode.krName),
                                        const SizedBox(height: 8.0),
                                        Image.asset(
                                          statusModel.imagePath,
                                          width: 50.0,
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(statModel.stat.toString()),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                            .toList(),
                        // List.generate(
                        //   6,
                        //   (index) => SizedBox(
                        //     width: constraint.maxWidth / 3,
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         const Text('미세먼지'),
                        //         const SizedBox(height: 8.0),
                        //         Image.asset(
                        //           'asset/img/bad.png',
                        //           width: 50.0,
                        //         ),
                        //         const SizedBox(height: 8.0),
                        //         const Text('46.0'),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
