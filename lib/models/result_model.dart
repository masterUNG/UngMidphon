import 'dart:convert';

class ResultModel {
  final String codeKey;
  final String codeName;
  final String codeValue;
  final String createStamp;
  ResultModel({
     this.codeKey,
     this.codeName,
     this.codeValue,
     this.createStamp,
  });

  ResultModel copyWith({
    String codeKey,
    String codeName,
    String codeValue,
    String createStamp,
  }) {
    return ResultModel(
      codeKey: codeKey ?? this.codeKey,
      codeName: codeName ?? this.codeName,
      codeValue: codeValue ?? this.codeValue,
      createStamp: createStamp ?? this.createStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'codeKey': codeKey,
      'codeName': codeName,
      'codeValue': codeValue,
      'createStamp': createStamp,
    };
  }

  factory ResultModel.fromMap(Map<String, dynamic> map) {
    return ResultModel(
      codeKey: map['codeKey'],
      codeName: map['codeName'],
      codeValue: map['codeValue'],
      createStamp: map['createStamp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultModel.fromJson(String source) => ResultModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ResultModel(codeKey: $codeKey, codeName: $codeName, codeValue: $codeValue, createStamp: $createStamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ResultModel &&
      other.codeKey == codeKey &&
      other.codeName == codeName &&
      other.codeValue == codeValue &&
      other.createStamp == createStamp;
  }

  @override
  int get hashCode {
    return codeKey.hashCode ^
      codeName.hashCode ^
      codeValue.hashCode ^
      createStamp.hashCode;
  }
}
