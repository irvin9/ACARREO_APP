class DialogMessageModel {
  final String title;
  final String description;

  DialogMessageModel({required this.title, required this.description});

  factory DialogMessageModel.fromMap(Map<String, dynamic> message) =>
      DialogMessageModel(
        title: message['title'],
        description: message['description'],
      );
}
