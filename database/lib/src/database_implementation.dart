import 'package:database/src/exceptions/count_exception.dart';
import 'package:database/src/exceptions/delete_exception.dart';
import 'package:database/src/exceptions/initiation_exception.dart';
import 'package:database/src/exceptions/query_exception.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:developer' as developer;

import 'const/item/content_keys.dart';
import 'const/item/topic_keys.dart';
import 'database_interface.dart';
import 'exceptions/insert_exception.dart';
import 'exceptions/update_exception.dart';

class DatabaseImplementation extends DatabaseInterface {
  late final Database _database;

  ///THESE ARE JUST EXAMPLES FOR PROJECT STARTER
  ///IMPROVISE THE COLUMN KEYS IN [content_keys.dart]
  ///IMPROVISE THE INTERFACE IN [DatabaseInterface]

  @override
  Future<void> configureDatabase(String dbName, int version) async {
    String databasePath = await getDatabasesPath();
    String path = ('$databasePath/$dbName');

    try {
      _database = await openDatabase(
        path,
        version: version,
        onCreate: (Database database, int version) async {
          ///Here, we can execute table creation SQL
          ///EXAMPLES:
          await database.execute('''
            CREATE TABLE $topicsTable (
              $topicIdColumn TEXT PRIMARY KEY,
              $topicTitleColumn TEXT NOT NULL,            
              $topicTimesCompletedColumn INT NOT NULL,
              $topicLastUpdatedColumn DATETIME NOT NULL
            )
          ''');

          ///EXAMPLE OF TABLE WITH FOREIGN KEY
          //create a table of contents for topics
          await database.execute('''
            CREATE TABLE $contentsTable (
              $contentIdColumn TEXT PRIMARY KEY,
              $contentTopicIdColumn TEXT NOT NULL,
              $contentTitleColumn TEXT NOT NULL,
              $contentDescriptionColumn TEXT,
              $contentLastUpdatedColumn TEXT NOT NULL,
              $contentImagePathColumn TEXT,
              $contentImageTypeColumn TEXT,
              $contentLinkColumn TEXT,
              FOREIGN KEY ($contentTopicIdColumn) REFERENCES $topicsTable ($topicIdColumn)
            )
          ''');
        },
      );
      developer.log('Database Opened in: ${_database.path}');
    } catch (e) {
      developer.log(e.toString());
      throw InitiationException(e.toString());
    }
  }

  ///INSERTION CODES HERE
  ///EXAMPLES:
  @override
  Future<void> insertExplanationTopic(Map<String, dynamic> topic) async {
    try {
      await _database.insert(topicsTable, topic);
    } catch (e) {
      developer.log('Insert Error: ${e.toString()}');
      throw InsertException(e.toString());
    }
  }

  @override
  Future<void> insertExplanationContent(Map<String, dynamic> content) async {
    try {
      await _database.insert(contentsTable, content);
    } catch (e) {
      developer.log('Insert Error: ${e.toString()}');
      throw InsertException(e.toString());
    }
  }

  ///INSERTION CODES HERE
  ///EXAMPLES:
  @override
  Future<Map<String, dynamic>> updateContent(Map<String, dynamic> item) async {
    developer
        .log('====UPDATED ENTRIES FOR DATABASE===\n${item.entries.join('\n')}');
    try {
      developer.log('Items to be added: ${item.values.join('-')}');
      await _database.update(contentsTable, item,
          where: '$contentIdColumn = ?', whereArgs: [item[contentIdColumn]]);
      return await getContentById(item[contentIdColumn]);
    } catch (e) {
      developer.log('Update Error: ${e.toString()}');
      throw UpdateException(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> updateTopic(Map<String, dynamic> item) async {
    developer
        .log('====UPDATED ENTRIES FOR DATABASE===\n${item.entries.join('\n')}');
    try {
      developer.log('Items to be added: ${item.values.join('-')}');
      await _database.update(topicsTable, item,
          where: '$topicIdColumn = ?', whereArgs: [item[topicIdColumn]]);
      Map<String, dynamic> newlyUpdatedTopic =
      await getTopicById(item[topicIdColumn]);
      return newlyUpdatedTopic;
    } catch (e) {
      developer.log('Update Error: ${e.toString()}');
      throw UpdateException(e.toString());
    }
  }

  ///DELETION CODES HERE
  ///EXAMPLES:
  @override
  Future<void> deleteContent(String id) async {
    try {
      await _database.delete(contentsTable,
          where: '$contentIdColumn = ?', whereArgs: [id]);
    } catch (e) {
      developer.log('Delete Error: ${e.toString()}');
      throw DeleteException(e.toString());
    }
  }

  ///EXAMPLE OF MULTIPLE DELETION
  ///RELATED TO OTHER TABLES
  @override
  Future<void> deleteTopic(String topicId) async {
    try {
      //delete all contents of the topic
      await _database.delete(contentsTable,
          where: '$contentTopicIdColumn = ?', whereArgs: [topicId]);
      //delete the topic
      await _database.delete(topicsTable,
          where: '$topicIdColumn = ?', whereArgs: [topicId]);
    } catch (e) {
      developer.log('Delete Error: ${e.toString()}');
      throw DeleteException(e.toString());
    }
  }

  ///EXAMPLE OF NUCLEAR DELETION
  @override
  Future<void> deleteAllData() async {
    try {
      await _database.delete(contentsTable);
      await _database.delete(topicsTable);
    } catch (e) {
      developer.log('Delete Error: ${e.toString()}');
      throw DeleteException(e.toString());
    }
  }

  ///RETRIEVAL CODES HERE
  ///EXAMPLES:
  @override
  Future<Map<String, dynamic>> getTopicById(String id) {
    developer.log('Getting topic with: $id Status');
    try {
      //get topic
      return _database.query(topicsTable,
          where: '$topicIdColumn = ?', whereArgs: [id]).then((value) {
        if (value.isNotEmpty) {
          return value.first;
        } else {
          return {};
        }
      });
    } catch (e) {
      developer.log('Throw Error: ${e.toString()}');
      throw QueryException(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> getContentById(String id) {
    developer.log('Getting content with: $id Status');
    try {
      //get content
      return _database.query(contentsTable,
          where: '$contentIdColumn = ?', whereArgs: [id]).then((value) {
        if (value.isNotEmpty) {
          return value.first;
        } else {
          return {};
        }
      });
    } catch (e) {
      developer.log('Throw Error: ${e.toString()}');
      throw QueryException(e.toString());
    }
  }

  ///MULTIPLE RETRIEVAL CODES HERE
  ///EXAMPLES:

  @override
  Future<List<Map<String, dynamic>>> getAllContentsByTopic(
      String topicId) async {
    developer.log('Getting all items with: $topicId Status');
    try {
      //get all contents of the topic
      return await _database.query(contentsTable,
          where: '$contentTopicIdColumn = ?', whereArgs: [topicId]);
    } catch (e) {
      developer.log('Throw Error: ${e.toString()}');
      throw QueryException(e.toString());
    }
  }

  //create a function that get all topics
  @override
  Future<List<Map<String, dynamic>>> getAllTopics() async {
    try {
      //get all topics
      return await _database.query(topicsTable);
    } catch (e) {
      developer.log('Throw Error: ${e.toString()}');
      throw QueryException(e.toString());
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllImagesPathOfATopic(
      String topicId) async {
    //get all image paths of contents in the topic
    try {
      return await _database.query(contentsTable,
          columns: [contentImagePathColumn],
          where: '$contentTopicIdColumn = ?',
          whereArgs: [topicId]);
    } catch (e) {
      developer.log('Throw Error: ${e.toString()}');
      throw QueryException(e.toString());
    }
  }

  ///EXAMPLE OF GETTING LIST OF VALUE IN COLUMNS OF AN IMAGE
  @override
  Future<List<Map<String, dynamic>>> getAllImagesPath() async {
    //get all image paths of all contents
    try {
      return await _database
          .query(contentsTable, columns: [contentImagePathColumn]);
    } catch (e) {
      developer.log('Throw Error: ${e.toString()}');
      throw QueryException(e.toString());
    }
  }

  ///COUNT TAGS CODE
  ///EXAMPLES:
  //create a function that counts all tags
  @override
  Future<int> countTopics() async {
    try {
      //get all tags
      return Sqflite.firstIntValue(
          await _database.rawQuery('SELECT COUNT(*) FROM $topicsTable')) ??
          0;
    } catch (e) {
      developer.log('Throw Error: ${e.toString()}');
      throw CountException(e.toString());
    }
  }
}