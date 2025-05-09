import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sobienote_flutter/common/const/data.dart';
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
    String? memberId = await secureStorage.read(key: MEMBER_ID_KEY);
    return reportRepository.getSatisfaction(year, int.parse(memberId!), month);
  }

  Future<BaseResponse<double>> getAvgSatisfaction(int year, int? month) async {
    String? memberId = await secureStorage.read(key: MEMBER_ID_KEY);
    return reportRepository.getAvgSatisfaction(
      year,
      int.parse(memberId!),
      month,
    );
  }

  Future<BaseResponse<List<ReportResponse>>> getFactors(
    int year,
    int? month,
  ) async {
    String? memberId = await secureStorage.read(key: MEMBER_ID_KEY);
    return reportRepository.getFactors(year, int.parse(memberId!), month);
  }

  Future<BaseResponse<List<ReportResponse>>> getEmotions(
    int year,
    int? month,
  ) async {
    String? memberId = await secureStorage.read(key: MEMBER_ID_KEY);
    return reportRepository.getEmotions(year, int.parse(memberId!), month);
  }

  Future<BaseResponse<List<ReportResponse>>> getCategories(
    int year,
    int? month,
  ) async {
    String? memberId = await secureStorage.read(key: MEMBER_ID_KEY);
    return reportRepository.getCategories(year, int.parse(memberId!), month);
  }
}
