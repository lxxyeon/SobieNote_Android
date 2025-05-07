import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sobienote_flutter/common/provider/secure_storage.dart';
import 'package:sobienote_flutter/common/response/base_response.dart';
import 'package:sobienote_flutter/report/report_repository.dart';
import 'package:sobienote_flutter/report/response/report_response.dart';

final reportNotifierProvider = Provider<ReportNotifier>((ref) {
  final repo = ref.watch(reportRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);
  return ReportNotifier(reportRepository: repo, secureStorage: storage);
});

class ReportNotifier {
  final ReportRepository reportRepository;
  final FlutterSecureStorage secureStorage;

  ReportNotifier({required this.reportRepository, required this.secureStorage});

  Future<BaseResponse<ReportResponse>> getSatisfaction(
    int year,
    int? month,
  ) async {
    String? memberId = await secureStorage.read(key: 'memberId');
    return reportRepository.getSatisfaction(year, 52, month);
  }

  Future<BaseResponse<double>> getAvgSatisfaction(
    int year,
    int? month,
  ) async {
    String? memberId = await secureStorage.read(key: 'memberId');
    return reportRepository.getAvgSatisfaction(year, 52, month);
  }

  Future<BaseResponse<List<ReportResponse>>> getFactors(int year, int? month) async {
    String? memberId = await secureStorage.read(key: 'memberId');
    return reportRepository.getFactors(year, 52, month);
  }

  Future<BaseResponse<List<ReportResponse>>> getEmotions(int year, int? month) async {
    String? memberId = await secureStorage.read(key: 'memberId');
    return reportRepository.getEmotions(year, 52, month);
  }

  Future<BaseResponse<List<ReportResponse>>> getCategories(
    int year,
    int? month,
  ) async {
    String? memberId = await secureStorage.read(key: 'memberId');
    return reportRepository.getCategories(year, 52, month);
  }
}
