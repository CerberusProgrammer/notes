class Note {
  String title;
  String content;

  Note(this.title, this.content);

  setTitle(String title) => this.title = title;
  String getTitle() => title;

  setContent(String content) => this.content = content;
  String getContent() => content;

  factory Note.fromJson(dynamic json) {
    return Note(
      json['title'] as String,
      json['content'] as String,
    );
  }

  Map<dynamic, dynamic> toJson() => {
        'title': title,
        'content': content,
      };

  @override
  String toString() {
    return '"title": $title, "content": $content';
  }
}
