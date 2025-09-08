class GetOfferDetailsResponseModel {
  bool? success;
  String? message;
  List<ErrorSource>? errorSources;
  Err? err;
  int? stack;

  GetOfferDetailsResponseModel({
    this.success,
    this.message,
    this.errorSources,
    this.err,
    this.stack,
  });

  factory GetOfferDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return GetOfferDetailsResponseModel(
      success: json['success'],
      message: json['message'],
      errorSources: json['errorSources'] != null
          ? List<ErrorSource>.from(
              json['errorSources'].map((x) => ErrorSource.fromJson(x)))
          : [],
      err: json['err'] != null ? Err.fromJson(json['err']) : null,
      stack: json['stack'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['success'] = success;
    result['message'] = message;
    if (errorSources != null) {
      result['errorSources'] = errorSources!.map((v) => v.toJson()).toList();
    }
    if (err != null) {
      result['err'] = err!.toJson();
    }
    result['stack'] = stack;
    return result;
  }
}

class ErrorSource {
  String? path;
  String? message;

  ErrorSource({this.path, this.message});

  factory ErrorSource.fromJson(Map<String, dynamic> json) {
    return ErrorSource(
      path: json['path'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['path'] = path;
    result['message'] = message;
    return result;
  }
}

class Err {
  String? stringValue;
  String? valueType;
  String? kind;
  String? value;
  String? path;
  Map<String, dynamic>? reason;
  String? name;
  String? message;

  Err({
    this.stringValue,
    this.valueType,
    this.kind,
    this.value,
    this.path,
    this.reason,
    this.name,
    this.message,
  });

  factory Err.fromJson(Map<String, dynamic> json) {
    return Err(
      stringValue: json['stringValue'],
      valueType: json['valueType'],
      kind: json['kind'],
      value: json['value'],
      path: json['path'],
      reason: json['reason'],
      name: json['name'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['stringValue'] = stringValue;
    result['valueType'] = valueType;
    result['kind'] = kind;
    result['value'] = value;
    result['path'] = path;
    result['reason'] = reason;
    result['name'] = name;
    result['message'] = message;
    return result;
  }
}
