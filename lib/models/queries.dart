class Queries{
  String name;
  String text;


  Queries(
      {required this.name, required this.text,}
      );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'text': text,
    };

  }


}