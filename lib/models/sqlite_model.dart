import 'dart:convert';

class SQLiteModel {
  final int id;
  final String codeKey;
  final String codeName;
  final String codeValue;
  final String codeStamp;
  SQLiteModel({
    this.id,
    this.codeKey,
    this.codeName,
    this.codeValue,
    this.codeStamp,
  });

  SQLiteModel copyWith({
    int id,
    String codeKey,
    String codeName,
    String codeValue,
    String codeStamp,
  }) {
    return SQLiteModel(
      id: id ?? this.id,
      codeKey: codeKey ?? this.codeKey,
      codeName: codeName ?? this.codeName,
      codeValue: codeValue ?? this.codeValue,
      codeStamp: codeStamp ?? this.codeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'codeKey': codeKey,
      'codeName': codeName,
      'codeValue': codeValue,
      'codeStamp': codeStamp,
    };
  }

  factory SQLiteModel.fromMap(Map<String, dynamic> map) {
    return SQLiteModel(
      id: map['id'],
      codeKey: map['codeKey'],
      codeName: map['codeName'],
      codeValue: map['codeValue'],
      codeStamp: map['codeStamp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SQLiteModel.fromJson(String source) => SQLiteModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SQLiteModel(id: $id, codeKey: $codeKey, codeName: $codeName, codeValue: $codeValue, codeStamp: $codeStamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SQLiteModel &&
      other.id == id &&
      other.codeKey == codeKey &&
      other.codeName == codeName &&
      other.codeValue == codeValue &&
      other.codeStamp == codeStamp;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      codeKey.hashCode ^
      codeName.hashCode ^
      codeValue.hashCode ^
      codeStamp.hashCode;
  }
}
