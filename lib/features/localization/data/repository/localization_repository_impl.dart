import 'package:attendance_tracker/core/error/error_reporter.dart';
import 'package:attendance_tracker/core/error/exception_factory.dart';
import 'package:attendance_tracker/core/error/failures.dart';
import 'package:attendance_tracker/core/logging/app_logger.dart';
import 'package:attendance_tracker/features/localization/cache/localization_cache_manager.dart';
import 'package:attendance_tracker/features/localization/data/datasources/local_localization_datasource.dart';
import 'package:attendance_tracker/features/localization/data/datasources/remote_localization_api.dart';
import 'package:attendance_tracker/features/localization/domain/repository/localization_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LocalizationRepository)
class LocalizationRepositoryImpl implements LocalizationRepository {
  final RemoteLocalizationApi _api;
  final LocalLocalizationDatasource _local;
  final LocalizationCacheManager _cache;

  LocalizationRepositoryImpl({
    required RemoteLocalizationApi api,
    required LocalLocalizationDatasource local,
    required LocalizationCacheManager cache,
  }) : _api = api,
       _local = local,
       _cache = cache;

  @override
  Future<Either<Map<String, dynamic>, Failure>> getTranslations({
    required String path,
    required String langCode,
    void Function()? onUpdate,
  }) async {
    try {
      final diskCache = await _cache.read(langCode);
      if (diskCache != null) {
        _refreshInBackground(langCode, path, onUpdate);
        return Left(diskCache);
      }
      final localJson = await _local.loadLocal(path, langCode);

      _downloadAndCache(langCode, path, onUpdate);

      return Left(localJson);
    } catch (e, s) {
      ErrorReporter().reportException(e, s);
      return Right(
        Failure(exception: AppExceptionFactory.identifyException(e, s)),
      );
    }
  }

  Future<void> _refreshInBackground(
    String langCode,
    String path,
    Function? onUpdate,
  ) async {
    final shouldRefresh = await _cache.shouldRefresh(langCode);
    if (!shouldRefresh) return;

    await _fetchAndUpdate(langCode, path, onUpdate);
  }

  Future<void> _downloadAndCache(
    String langCode,
    String path,
    Function? onUpdate,
  ) async {
    await _fetchAndUpdate(langCode, path, onUpdate);
  }

  Future<void> _fetchAndUpdate(
    String langCode,
    String path,
    Function? onUpdate,
  ) async {
    try {
      AppLogger().info(
        "🔄 Fetching latest localizations for '$langCode' from API...",
      );
      await Future.delayed(const Duration(seconds: 20));

      final result = await _api.fetchLocalizations(langCode);

      final remoteJson = result.fold((response) => response.data, (_) => null);
      if (remoteJson == null) return;

      final oldCache = await _cache.read(langCode);

      await _cache.write(langCode, remoteJson);
      await _cache.saveLastFetch(langCode);
      if (onUpdate != null &&
          (oldCache == null || !mapEquals(oldCache, remoteJson))) {
        AppLogger().info('New Localization Data Synced & UI Updated');
        onUpdate();
      }
    } catch (e, s) {
      ErrorReporter().reportException(e, s);
    }
  }
}
