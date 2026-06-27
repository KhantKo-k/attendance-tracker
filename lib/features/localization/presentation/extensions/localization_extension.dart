import 'package:attendance_tracker/features/localization/presentation/services/localization_service.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

extension LocalizationContext on BuildContext {
  String tr(String key, {List<Object>? args, Map<String, Object>? namedArgs}) {
    final translations = watch<LocalizationService>().translations;
    return _tanslate(translations, key, args, namedArgs);

    // dynamic value;
    // if(key.contains('.')){
    //   final keys = key.split('.');
    //   dynamic current = translations;
    //   for(var k in keys) {
    //     if (current is Map && current.containsKey(k)){
    //       current = current[k];
    //     } else {
    //       return ' . . . . . ';
    //     }
    //   }
    //   value = current;
    // } else {
    //   value = translations[key];
    // }

    // if(value == null) return '-';

    // String text = value.toString();
    // if(args != null) {
    //   for(var i = 0; i < args.length; i++){
    //     text = text.replaceAll('{$i}', args[i].toString());
    //   }
    // }

    // if (namedArgs != null) {
    //   namedArgs.forEach((k, v) {
    //     text = text.replaceAll('{$k}', v.toString());
    //   });
    // }

    // return text;
  }

  String trRead(
    String key, {
    List<Object>? args,
    Map<String, Object>? namedArgs,
  }) {
    final translations = read<LocalizationService>().translations;
    return _tanslate(translations, key, args, namedArgs);
  }

  String _tanslate(
    Map<String, dynamic> translations,
    String key,
    List<Object>? args,
    Map<String, Object>? namedArgs,
  ) {
    dynamic value;
    if (key.contains('.')) {
      final keys = key.split('.');
      dynamic current = translations;
      for (var k in keys) {
        if (current is Map && current.containsKey(k)) {
          current = current[k];
        } else {
          return ' . . . . . ';
        }
      }
      value = current;
    } else {
      value = translations[key];
    }

    if (value == null) return '-';

    String text = value.toString();
    if (args != null) {
      for (var i = 0; i < args.length; i++) {
        text = text.replaceAll('{$i}', args[i].toString());
      }
    }

    if (namedArgs != null) {
      namedArgs.forEach((k, v) {
        text = text.replaceAll('{$k}', v.toString());
      });
    }

    return text;
  }
}



    
    // if(key.contains('.')){
    //   final keys = key.split('.');
    //   dynamic current = translations;
    //   for(var k in keys){
    //     if (current is Map && current.containsKey(k)) {
    //       current = current[k];
    //     } else {
    //       return '- - - -';
    //     }
    //   }
    //   return current.toString();
    // }

    // return translations[key]?.toString() ?? '- - - -'; 
