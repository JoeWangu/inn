// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main

class _AuthApi implements AuthApi {
  _AuthApi(this._dio, {this.baseUrl, this.errorLogger});

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<SignupResponse> signUp(SignUpRequest request) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'requiresToken': 'false'};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _options = _setStreamType<SignupResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'users/',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late SignupResponse _value;
    try {
      _value = SignupResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'requiresToken': 'false'};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _options = _setStreamType<LoginResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'users/login/',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late LoginResponse _value;
    try {
      _value = LoginResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserProfileModel> getUserProfile() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserProfileModel>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'user-profile/',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late UserProfileModel _value;
    try {
      _value = UserProfileModel.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserProfileModel> createUserProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? dob,
    String? gender,
    String? address,
    String? bio,
    int? country,
    int? state,
    int? city,
    int? neighborhood,
    File? profilePicture,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData();
    if (firstName != null) {
      _data.fields.add(MapEntry('first_name', firstName));
    }
    if (lastName != null) {
      _data.fields.add(MapEntry('last_name', lastName));
    }
    if (phoneNumber != null) {
      _data.fields.add(MapEntry('phone_number', phoneNumber));
    }
    if (dob != null) {
      _data.fields.add(MapEntry('dob', dob));
    }
    if (gender != null) {
      _data.fields.add(MapEntry('gender', gender));
    }
    if (address != null) {
      _data.fields.add(MapEntry('address', address));
    }
    if (bio != null) {
      _data.fields.add(MapEntry('bio', bio));
    }
    if (country != null) {
      _data.fields.add(MapEntry('country', country.toString()));
    }
    if (state != null) {
      _data.fields.add(MapEntry('state', state.toString()));
    }
    if (city != null) {
      _data.fields.add(MapEntry('city', city.toString()));
    }
    if (neighborhood != null) {
      _data.fields.add(MapEntry('neighborhood', neighborhood.toString()));
    }
    if (profilePicture != null) {
      _data.files.add(
        MapEntry(
          'profile_picture',
          MultipartFile.fromFileSync(
            profilePicture.path,
            filename: profilePicture.path.split(Platform.pathSeparator).last,
          ),
        ),
      );
    }
    final _options = _setStreamType<UserProfileModel>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'multipart/form-data',
          )
          .compose(
            _dio.options,
            'user-profile/',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late UserProfileModel _value;
    try {
      _value = UserProfileModel.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserProfileModel> updateUserProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? dob,
    String? gender,
    String? address,
    String? bio,
    int? country,
    int? state,
    int? city,
    int? neighborhood,
    File? profilePicture,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData();
    if (firstName != null) {
      _data.fields.add(MapEntry('first_name', firstName));
    }
    if (lastName != null) {
      _data.fields.add(MapEntry('last_name', lastName));
    }
    if (phoneNumber != null) {
      _data.fields.add(MapEntry('phone_number', phoneNumber));
    }
    if (dob != null) {
      _data.fields.add(MapEntry('dob', dob));
    }
    if (gender != null) {
      _data.fields.add(MapEntry('gender', gender));
    }
    if (address != null) {
      _data.fields.add(MapEntry('address', address));
    }
    if (bio != null) {
      _data.fields.add(MapEntry('bio', bio));
    }
    if (country != null) {
      _data.fields.add(MapEntry('country', country.toString()));
    }
    if (state != null) {
      _data.fields.add(MapEntry('state', state.toString()));
    }
    if (city != null) {
      _data.fields.add(MapEntry('city', city.toString()));
    }
    if (neighborhood != null) {
      _data.fields.add(MapEntry('neighborhood', neighborhood.toString()));
    }
    if (profilePicture != null) {
      _data.files.add(
        MapEntry(
          'profile_picture',
          MultipartFile.fromFileSync(
            profilePicture.path,
            filename: profilePicture.path.split(Platform.pathSeparator).last,
          ),
        ),
      );
    }
    final _options = _setStreamType<UserProfileModel>(
      Options(
            method: 'PATCH',
            headers: _headers,
            extra: _extra,
            contentType: 'multipart/form-data',
          )
          .compose(
            _dio.options,
            'user-profile/',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late UserProfileModel _value;
    try {
      _value = UserProfileModel.fromJson(_result.data!);
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

@ProviderFor(authApi)
const authApiProvider = AuthApiProvider._();

final class AuthApiProvider
    extends $FunctionalProvider<AuthApi, AuthApi, AuthApi>
    with $Provider<AuthApi> {
  const AuthApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authApiHash();

  @$internal
  @override
  $ProviderElement<AuthApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthApi create(Ref ref) {
    return authApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthApi>(value),
    );
  }
}

String _$authApiHash() => r'dbbb2d008b985842adeba1493ce81c72955b7ba7';
