import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:bloc_task/infrastructure/models/response/git_data_response_model.dart';

@singleton
class LocalDatabase {
  static const String gitRepoTable = 'git_repo_data';

  static final LocalDatabase _instance = LocalDatabase._internal();

  factory LocalDatabase() {
    return _instance;
  }

  LocalDatabase._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'app_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $gitRepoTable('
              'id INTEGER PRIMARY KEY, '
              'name TEXT, '
              'description TEXT, '
              'html_url TEXT, '
              'stargazers_count INTEGER)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < newVersion) {
          db.execute('ALTER TABLE $gitRepoTable ADD COLUMN html_url TEXT');
          db.execute('ALTER TABLE $gitRepoTable ADD COLUMN stargazers_count INTEGER');
        }
      },
      version: 2,
    );
  }



  Future<List<GitDataResponseModel>> getGitRepoData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(gitRepoTable);
    return List.generate(maps.length, (i) {
      return GitDataResponseModel.fromJson(maps[i]);
    });
  }

  Batch batch() {
    return _database!.batch();
  }
}
