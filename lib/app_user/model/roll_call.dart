class RollCall {
  RollCall({
    this.date,
    this.checked,
    this.score,
  });

  DateTime? date;
  bool? checked;
  int? score;

  factory RollCall.fromJson(Map<String, dynamic> json) => RollCall(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        checked: json["checked"] == null ? null : json["checked"],
        score: json["score"] == null ? null : json["score"],
      );
}
