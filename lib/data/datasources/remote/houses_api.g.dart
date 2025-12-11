// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'houses_api.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main

class _HousesApi implements HousesApi {
  _HousesApi(this._dio, {this.baseUrl, this.errorLogger});

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<PaginatedResponse<HouseModel>> fetchHouses({int page = 1}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<PaginatedResponse<HouseModel>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'houses/',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late PaginatedResponse<HouseModel> _value;
    try {
      _value = PaginatedResponse<HouseModel>.fromJson(
        _result.data!,
        (json) => HouseModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, _result);
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

// dart format on

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(housesApi)
const housesApiProvider = HousesApiProvider._();

final class HousesApiProvider
    extends $FunctionalProvider<HousesApi, HousesApi, HousesApi>
    with $Provider<HousesApi> {
  const HousesApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'housesApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$housesApiHash();

  @$internal
  @override
  $ProviderElement<HousesApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HousesApi create(Ref ref) {
    return housesApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HousesApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HousesApi>(value),
    );
  }
}

String _$housesApiHash() => r'ded00aac1d6308eb1eb9ba5e36d82c2c85b7a3c2';
