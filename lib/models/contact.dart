class Contact {
  final int id;
  String name;
  String number;

  String avatarUrl;

  Contact({
    required this.id,
    required this.name,
    required this.number,
    required this.avatarUrl,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      number: json['number'],
      avatarUrl: json['avatar_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'number': number, 'avatar_url': avatarUrl};
  }
}
