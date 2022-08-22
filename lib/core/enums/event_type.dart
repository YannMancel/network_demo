enum EventType {
  add,
  update,
  fail,
  dispose;

  int get _lengthMax {
    return EventType.values
        .map((e) => e.name.length)
        .reduce((a, b) => (a < b) ? b : a);
  }

  String get formattedName => name.toUpperCase().padRight(_lengthMax);
}
