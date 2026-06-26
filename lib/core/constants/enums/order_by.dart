enum OrderBy {
  asc,
  desc;

  @override
  String toString() => name;
}

String? serializeOrderBy(OrderBy? orderBy) => orderBy?.toString();