import 'package:mysql1/mysql1.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String host = dotenv.env['AWS_HOST']!;
final int port = int.parse(dotenv.env['AWS_PORT']!);
final String? user = dotenv.env['AWS_USER'];
final String? password = dotenv.env['AWS_PASSWORD'];
final String? db = dotenv.env['AWS_DB_NAME'];

Future<MySqlConnection> _getConnection() async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
    host: host,
    port: port,
    user: user,
    password: password,
    db: db,
  ));
  return conn;
}

Future<void> addOrUpdateItem(String code, String locationKey) async {
  final conn = await _getConnection();
  try {
    await conn.query(
      'UPDATE `VMStset`.`VMS_TestDB` SET `관리번호` = ? WHERE `LocationKey` = ?',
      [code, locationKey],
    );
  } finally {
    await conn.close();
  }
}

Future<void> setItemAsOutbound(String code) async {
  final conn = await _getConnection();
  try {
    await conn.query(
      'UPDATE `VMStset`.`VMS_TestDB` SET `관리번호` = "" WHERE `관리번호` = ?',
      [code],
    );
  } finally {
    await conn.close();
  }
}

Future<List<String>> getEmptySpaces() async {
  final conn = await _getConnection();
  List<String> emptySpaces = [];

  try {
    final results = await conn.query(
      'SELECT `LocationKey` FROM `VMStset`.`VMS_TestDB` WHERE `관리번호` = ""',
    );

    for (var row in results) {
      emptySpaces.add(row[0].toString());
    }
  } finally {
    await conn.close();
  }

  return emptySpaces;
}

Future<void> moveItem(String code, String newLocationKey) async {
  final conn = await _getConnection();
  try {
    // Set the 관리번호 to an empty string in the old location
    await conn.query(
      'UPDATE `VMStset`.`VMS_TestDB` SET `관리번호` = "" WHERE `관리번호` = ?',
      [code],
    );

    // Update the 관리번호 in the new location
    await conn.query(
      'UPDATE `VMStset`.`VMS_TestDB` SET `관리번호` = ? WHERE `LocationKey` = ?',
      [code, newLocationKey],
    );
  } finally {
    await conn.close();
  }
}

