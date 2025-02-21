class BoardingModel {
  final String name;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final bool isOpen;
  final double distance;
  final double price;
  final String startDay;
  final String endDay;
  final double startTime;
  final double endTime;

  BoardingModel({required this.name, required this.imageUrl, required this.distance, required this.startDay, required this.endDay, required this.endTime, required this.startTime, required this.isOpen, required this.price, required this.rating, required this.reviewCount});
}
