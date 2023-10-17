class SearchResult {
  final String keyword;
  final DateTime searchDate;

  SearchResult({
    required this.keyword,
    required this.searchDate,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      keyword: json['keyword'],
      searchDate: DateTime.parse(json['searchDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'keyword': keyword,
      'searchDate': searchDate.toIso8601String(),
    };
  }
}
