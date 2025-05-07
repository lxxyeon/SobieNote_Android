// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_repository.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations

class _ReportRepository implements ReportRepository {
  _ReportRepository(this._dio, {this.baseUrl, this.errorLogger});

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<BaseResponse<ReportResponse>> getSatisfaction(
    int year,
    int memberId,
    int? month,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'month': month};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'accessToken': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<BaseResponse<ReportResponse>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/satisfactions/${year}/${memberId}',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseResponse<ReportResponse> _value;
    try {
      _value = BaseResponse<ReportResponse>.fromJson(
        _result.data!,
        (json) => ReportResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseResponse<double>> getAvgSatisfaction(
    int year,
    int memberId,
    int? month,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'month': month};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'accessToken': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<BaseResponse<double>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/satisfactions/avg/${year}/${memberId}',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseResponse<double> _value;
    try {
      _value = BaseResponse<double>.fromJson(
        _result.data!,
        (json) => json as double,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseResponse<List<ReportResponse>>> getFactors(
    int year,
    int memberId,
    int? month,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'month': month};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'accessToken': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<BaseResponse<List<ReportResponse>>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/factors/${year}/${memberId}',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseResponse<List<ReportResponse>> _value;
    try {
      _value = BaseResponse<List<ReportResponse>>.fromJson(
        _result.data!,
        (json) =>
            json is List<dynamic>
                ? json
                    .map<ReportResponse>(
                      (i) => ReportResponse.fromJson(i as Map<String, dynamic>),
                    )
                    .toList()
                : List.empty(),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseResponse<List<ReportResponse>>> getEmotions(
    int year,
    int memberId,
    int? month,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'month': month};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'accessToken': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<BaseResponse<List<ReportResponse>>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/emotions/${year}/${memberId}',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseResponse<List<ReportResponse>> _value;
    try {
      _value = BaseResponse<List<ReportResponse>>.fromJson(
        _result.data!,
        (json) =>
            json is List<dynamic>
                ? json
                    .map<ReportResponse>(
                      (i) => ReportResponse.fromJson(i as Map<String, dynamic>),
                    )
                    .toList()
                : List.empty(),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseResponse<List<ReportResponse>>> getCategories(
    int year,
    int memberId,
    int? month,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'month': month};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'accessToken': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<BaseResponse<List<ReportResponse>>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/categories/${year}/${memberId}',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseResponse<List<ReportResponse>> _value;
    try {
      _value = BaseResponse<List<ReportResponse>>.fromJson(
        _result.data!,
        (json) =>
            json is List<dynamic>
                ? json
                    .map<ReportResponse>(
                      (i) => ReportResponse.fromJson(i as Map<String, dynamic>),
                    )
                    .toList()
                : List.empty(),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
