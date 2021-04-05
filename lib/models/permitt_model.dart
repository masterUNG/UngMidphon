import 'dart:convert';

class PermittModel {
  final bool createPermit;
  final bool readPermit;
  final bool updatePermit;
  final bool deletePermit;
  PermittModel({
    this.createPermit,
    this.readPermit,
    this.updatePermit,
    this.deletePermit,
  });

  PermittModel copyWith({
    bool createPermit,
    bool readPermit,
    bool updatePermit,
    bool deletePermit,
  }) {
    return PermittModel(
      createPermit: createPermit ?? this.createPermit,
      readPermit: readPermit ?? this.readPermit,
      updatePermit: updatePermit ?? this.updatePermit,
      deletePermit: deletePermit ?? this.deletePermit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'createPermit': createPermit,
      'readPermit': readPermit,
      'updatePermit': updatePermit,
      'deletePermit': deletePermit,
    };
  }

  factory PermittModel.fromMap(Map<String, dynamic> map) {
    return PermittModel(
      createPermit: map['createPermit'],
      readPermit: map['readPermit'],
      updatePermit: map['updatePermit'],
      deletePermit: map['deletePermit'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PermittModel.fromJson(String source) => PermittModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PermittModel(createPermit: $createPermit, readPermit: $readPermit, updatePermit: $updatePermit, deletePermit: $deletePermit)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PermittModel &&
      other.createPermit == createPermit &&
      other.readPermit == readPermit &&
      other.updatePermit == updatePermit &&
      other.deletePermit == deletePermit;
  }

  @override
  int get hashCode {
    return createPermit.hashCode ^
      readPermit.hashCode ^
      updatePermit.hashCode ^
      deletePermit.hashCode;
  }
}
