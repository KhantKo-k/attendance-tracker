import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

abstract class LocalLocalizationDatasource {
  Future<Map<String, dynamic>> loadLocal(String path, String lang);
}

@Injectable(as: LocalLocalizationDatasource)
class LocalLocalizationDatasourceImpl implements LocalLocalizationDatasource{
  const LocalLocalizationDatasourceImpl();

  @override
  Future<Map<String, dynamic>> loadLocal(String path, String lang) async {
    final jsonStr = await rootBundle.loadString('$path/$lang.json');
    return json.decode(jsonStr);
  }
}