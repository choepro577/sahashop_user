class ScoreHistoryItem {
  ScoreHistoryItem({
    this.id,
    this.content,
    this.score,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? content;
  int? score;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ScoreHistoryItem.fromJson(Map<String, dynamic> json) =>
      ScoreHistoryItem(
        id: json["id"] == null ? null : json["id"],
        content: json["content"] == null ? null : json["content"],
        score: json["score"] == null ? null : json["score"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}
