import 'fields.dart';

class Query {
  String query;
  Pool pool;
  Field field;
  Campus campus;
  Department department;
  School school;

  void setQuery(String newQuery) {
    query = newQuery;
  }

  void setPool(Pool newPool) {
    pool = newPool;
  }

  void setField(Field newField) {
    field = newField;
  }

  void setCampus(Campus newCampus) {
    campus = newCampus;
  }

  void setDepartment(Department newDepartment) {
    department = newDepartment;
  }

  void setSchool(School newSchool) {
    school = newSchool;
  }

  Query(this.query, this.pool, this.field, this.campus, this.department, this.school);
}
