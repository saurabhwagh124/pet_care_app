class NotificationDtoModel {
    NotificationDtoModel({
        required this.title,
        required this.body,
        required this.image,
    });

    final String? title;
    final String? body;
    final String? image;

    factory NotificationDtoModel.fromJson(Map<String, dynamic> json){ 
        return NotificationDtoModel(
            title: json["title"],
            body: json["body"],
            image: json["image"],
        );
    }

    Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "image": image,
    };

    @override
    String toString(){
        return "$title, $body, $image, ";
    }
}
