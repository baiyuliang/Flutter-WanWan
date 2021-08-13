// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class User extends DataClass implements Insertable<User> {
  final int id;
  final String userid;
  final String pwd;
  final String nickname;
  final String avatar;
  final String imToken;
  User(
      {@required this.id,
      @required this.userid,
      @required this.pwd,
      @required this.nickname,
      @required this.avatar,
      @required this.imToken});
  factory User.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return User(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      userid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}userid']),
      pwd: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}pwd']),
      nickname: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nickname']),
      avatar: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}avatar']),
      imToken: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}im_token']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || userid != null) {
      map['userid'] = Variable<String>(userid);
    }
    if (!nullToAbsent || pwd != null) {
      map['pwd'] = Variable<String>(pwd);
    }
    if (!nullToAbsent || nickname != null) {
      map['nickname'] = Variable<String>(nickname);
    }
    if (!nullToAbsent || avatar != null) {
      map['avatar'] = Variable<String>(avatar);
    }
    if (!nullToAbsent || imToken != null) {
      map['im_token'] = Variable<String>(imToken);
    }
    return map;
  }

  UserTableCompanion toCompanion(bool nullToAbsent) {
    return UserTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      userid:
          userid == null && nullToAbsent ? const Value.absent() : Value(userid),
      pwd: pwd == null && nullToAbsent ? const Value.absent() : Value(pwd),
      nickname: nickname == null && nullToAbsent
          ? const Value.absent()
          : Value(nickname),
      avatar:
          avatar == null && nullToAbsent ? const Value.absent() : Value(avatar),
      imToken: imToken == null && nullToAbsent
          ? const Value.absent()
          : Value(imToken),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      userid: serializer.fromJson<String>(json['userid']),
      pwd: serializer.fromJson<String>(json['pwd']),
      nickname: serializer.fromJson<String>(json['nickname']),
      avatar: serializer.fromJson<String>(json['avatar']),
      imToken: serializer.fromJson<String>(json['imToken']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userid': serializer.toJson<String>(userid),
      'pwd': serializer.toJson<String>(pwd),
      'nickname': serializer.toJson<String>(nickname),
      'avatar': serializer.toJson<String>(avatar),
      'imToken': serializer.toJson<String>(imToken),
    };
  }

  User copyWith(
          {int id,
          String userid,
          String pwd,
          String nickname,
          String avatar,
          String imToken}) =>
      User(
        id: id ?? this.id,
        userid: userid ?? this.userid,
        pwd: pwd ?? this.pwd,
        nickname: nickname ?? this.nickname,
        avatar: avatar ?? this.avatar,
        imToken: imToken ?? this.imToken,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('userid: $userid, ')
          ..write('pwd: $pwd, ')
          ..write('nickname: $nickname, ')
          ..write('avatar: $avatar, ')
          ..write('imToken: $imToken')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          userid.hashCode,
          $mrjc(
              pwd.hashCode,
              $mrjc(nickname.hashCode,
                  $mrjc(avatar.hashCode, imToken.hashCode))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.userid == this.userid &&
          other.pwd == this.pwd &&
          other.nickname == this.nickname &&
          other.avatar == this.avatar &&
          other.imToken == this.imToken);
}

class UserTableCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> userid;
  final Value<String> pwd;
  final Value<String> nickname;
  final Value<String> avatar;
  final Value<String> imToken;
  const UserTableCompanion({
    this.id = const Value.absent(),
    this.userid = const Value.absent(),
    this.pwd = const Value.absent(),
    this.nickname = const Value.absent(),
    this.avatar = const Value.absent(),
    this.imToken = const Value.absent(),
  });
  UserTableCompanion.insert({
    this.id = const Value.absent(),
    @required String userid,
    @required String pwd,
    @required String nickname,
    @required String avatar,
    @required String imToken,
  })  : userid = Value(userid),
        pwd = Value(pwd),
        nickname = Value(nickname),
        avatar = Value(avatar),
        imToken = Value(imToken);
  static Insertable<User> custom({
    Expression<int> id,
    Expression<String> userid,
    Expression<String> pwd,
    Expression<String> nickname,
    Expression<String> avatar,
    Expression<String> imToken,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userid != null) 'userid': userid,
      if (pwd != null) 'pwd': pwd,
      if (nickname != null) 'nickname': nickname,
      if (avatar != null) 'avatar': avatar,
      if (imToken != null) 'im_token': imToken,
    });
  }

  UserTableCompanion copyWith(
      {Value<int> id,
      Value<String> userid,
      Value<String> pwd,
      Value<String> nickname,
      Value<String> avatar,
      Value<String> imToken}) {
    return UserTableCompanion(
      id: id ?? this.id,
      userid: userid ?? this.userid,
      pwd: pwd ?? this.pwd,
      nickname: nickname ?? this.nickname,
      avatar: avatar ?? this.avatar,
      imToken: imToken ?? this.imToken,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userid.present) {
      map['userid'] = Variable<String>(userid.value);
    }
    if (pwd.present) {
      map['pwd'] = Variable<String>(pwd.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    if (imToken.present) {
      map['im_token'] = Variable<String>(imToken.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserTableCompanion(')
          ..write('id: $id, ')
          ..write('userid: $userid, ')
          ..write('pwd: $pwd, ')
          ..write('nickname: $nickname, ')
          ..write('avatar: $avatar, ')
          ..write('imToken: $imToken')
          ..write(')'))
        .toString();
  }
}

class $UserTableTable extends UserTable with TableInfo<$UserTableTable, User> {
  final GeneratedDatabase _db;
  final String _alias;
  $UserTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _useridMeta = const VerificationMeta('userid');
  GeneratedColumn<String> _userid;
  @override
  GeneratedColumn<String> get userid =>
      _userid ??= GeneratedColumn<String>('userid', aliasedName, false,
          typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _pwdMeta = const VerificationMeta('pwd');
  GeneratedColumn<String> _pwd;
  @override
  GeneratedColumn<String> get pwd =>
      _pwd ??= GeneratedColumn<String>('pwd', aliasedName, false,
          typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _nicknameMeta = const VerificationMeta('nickname');
  GeneratedColumn<String> _nickname;
  @override
  GeneratedColumn<String> get nickname =>
      _nickname ??= GeneratedColumn<String>('nickname', aliasedName, false,
          typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  GeneratedColumn<String> _avatar;
  @override
  GeneratedColumn<String> get avatar =>
      _avatar ??= GeneratedColumn<String>('avatar', aliasedName, false,
          typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _imTokenMeta = const VerificationMeta('imToken');
  GeneratedColumn<String> _imToken;
  @override
  GeneratedColumn<String> get imToken =>
      _imToken ??= GeneratedColumn<String>('im_token', aliasedName, false,
          typeName: 'TEXT', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userid, pwd, nickname, avatar, imToken];
  @override
  String get aliasedName => _alias ?? 'user_table';
  @override
  String get actualTableName => 'user_table';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('userid')) {
      context.handle(_useridMeta,
          userid.isAcceptableOrUnknown(data['userid'], _useridMeta));
    } else if (isInserting) {
      context.missing(_useridMeta);
    }
    if (data.containsKey('pwd')) {
      context.handle(
          _pwdMeta, pwd.isAcceptableOrUnknown(data['pwd'], _pwdMeta));
    } else if (isInserting) {
      context.missing(_pwdMeta);
    }
    if (data.containsKey('nickname')) {
      context.handle(_nicknameMeta,
          nickname.isAcceptableOrUnknown(data['nickname'], _nicknameMeta));
    } else if (isInserting) {
      context.missing(_nicknameMeta);
    }
    if (data.containsKey('avatar')) {
      context.handle(_avatarMeta,
          avatar.isAcceptableOrUnknown(data['avatar'], _avatarMeta));
    } else if (isInserting) {
      context.missing(_avatarMeta);
    }
    if (data.containsKey('im_token')) {
      context.handle(_imTokenMeta,
          imToken.isAcceptableOrUnknown(data['im_token'], _imTokenMeta));
    } else if (isInserting) {
      context.missing(_imTokenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String tablePrefix}) {
    return User.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UserTableTable createAlias(String alias) {
    return $UserTableTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $UserTableTable _userTable;
  $UserTableTable get userTable => _userTable ??= $UserTableTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [userTable];
}
