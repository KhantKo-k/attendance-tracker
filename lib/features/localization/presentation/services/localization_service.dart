

import 'package:attendance_tracker/core/error/error_reporter.dart';
import 'package:attendance_tracker/features/localization/cache/localization_cache_manager.dart';
import 'package:attendance_tracker/features/localization/domain/usecases/get_translations_use_case.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton 
class LocalizationService extends ChangeNotifier{
  final GetTranslationUsecase _getTranslationUsecase;
  final LocalizationCacheManager _cache;

  static const String _selectedLocaleKey = 'selected_locale';
  Map<String, dynamic> _translations = {};
  Locale _currentLocale = const Locale('en');

  LocalizationService(this._getTranslationUsecase, this._cache);

  Map<String, dynamic> get translations => _translations;
  Locale get currentLocale => _currentLocale;

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLang = prefs.getString(_selectedLocaleKey);

    if(savedLang != null) {
      _currentLocale = Locale(savedLang);
    } 
    await _loadLanguage(_currentLocale.languageCode);
  }

  Future<void> changeLocale(Locale locale) async {
    if(locale == _currentLocale) return;

    _currentLocale = locale;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedLocaleKey, locale.languageCode);

    await _loadLanguage(locale.languageCode);
  }

  Future<void> _loadLanguage(String langCode) async {
    final result = await _getTranslationUsecase.call(
      path: 'assets/localizations', 
      langCode: langCode,
      onUpdate: () => _handleLiveBackgroundUpdate(langCode),
    );
    result.fold(
      (data){
        _translations = data;
        notifyListeners();
      },
      (failure) {
        ErrorReporter().reportException(failure.exception);
      },
    );
  }

  void _handleLiveBackgroundUpdate(String langCode) async {
    if (_currentLocale.languageCode != langCode) return;
    final freshData = await _cache.read(langCode);
    if(freshData != null){
      _translations = freshData;
      debugPrint("********** Localization Updated in Background & UI Refreshed **********");
      notifyListeners();
    }
  }
}