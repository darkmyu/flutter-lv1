import 'package:dio/dio.dart';
import 'package:dusty_dust/model/stat_model.dart';

class StatRepository {
  static Future<List<StatModel>> fetchData({
    required ItemCode itemCode,
  }) async {
    final itemCodeStr = itemCode == ItemCode.PM25 ? 'PM2.5' : itemCode.name;

    final response = await Dio().get(
      'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst',
      queryParameters: {
        'serviceKey': '',
        'returnType': 'json',
        'numOfRows': 100,
        'pageNo': 1,
        'itemCode': itemCodeStr,
        'dataGubun': 'HOUR',
        'searchCondition': 'WEEK',
      },
    );

    final rawItemsList = response.data['response']['body']['items'];

    List<StatModel> stats = [];

    final List<String> skipKeys = [
      'dataGubun',
      'dataTime',
      'itemCode',
    ];

    for (Map<String, dynamic> item in rawItemsList) {
      final dateTime = item['dataTime'];

      for (String key in item.keys) {
        if (skipKeys.contains(key)) {
          continue;
        }

        final regionStr = key;
        final stat = item[regionStr];

        stats = [
          ...stats,
          StatModel(
            region: Region.values.firstWhere((e) => e.name == regionStr),
            stat: double.parse(stat),
            itemCode: itemCode,
            dateTime: DateTime.parse(dateTime),
          ),
        ];
      }
    }

    return stats;
  }
}
