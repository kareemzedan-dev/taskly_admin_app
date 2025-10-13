
import 'package:taskly_admin/features/reviews/domain/entities/reviews_entity/reviews_entity.dart';

class ReviewsModel extends ReviewsEntity {
  ReviewsModel({
    required super.id,
    required super.freelancerId,
    required super.clientId,
    required super.orderId,
    required super.comment,
    required super.rating,
    required super.createdAt,
    required super.role,
  });

 
factory ReviewsModel.fromJson(Map<String, dynamic> json) {
  return ReviewsModel(
    id: json['id'] ?? '',
    freelancerId: json['freelancer_id'] ?? '',
    clientId: json['client_id'] ?? '',
    orderId: json['order_id'] ?? '',
    comment: json['comment'] ?? '',
    rating: json['rating']?.toString() ?? '0',
    createdAt: json['created_at'] ?? '',
    role: json['role'] ?? '',
  );
}


 
  Map<String, dynamic> toJson() {
    return {
      'freelancer_id': freelancerId,
      'client_id': clientId,
      'order_id': orderId,
      'comment': comment,
      'rating': rating,
      'created_at': createdAt,
      'role': role
    };
  }
}
