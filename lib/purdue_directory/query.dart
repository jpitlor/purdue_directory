import 'fields.dart';

class Query {
  String _query;
  Pool _pool;
  SearchBy _searchBy;
  Campus _campus;
  Department _department;
  School _school;

  String get query => _query;

  Pool get pool => _pool;

  Query(this._query, this._pool, this._searchBy, this._campus, this._department, this._school);

  SearchBy get searchBy => _searchBy;

  Campus get campus => _campus;

  Department get department => _department;

  School get school => _school;
}
