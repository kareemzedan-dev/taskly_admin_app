

import '../../../../attachments/data/models/attachments_dm/attachments_dm.dart';
import '../../../domain/entities/order_entity/order_entity.dart';

class OrderDm extends OrderEntity {
  OrderDm({
    required super.id,
    required super.clientId,
    super.freelancerId,
    required super.title,
    super.description,
    super.category,
    super.attachments,
    super.serviceType,
    super.budget,
    super.status,
    super.deadline,
    required super.createdAt,
    required super.updatedAt,
    required super.offersCount,
    super.workStartedAt,
    super.completedAt,
    super.paymentConfirmedAt,
  });

  factory OrderDm.fromJson(Map<String, dynamic> json) {
    return OrderDm(
      id: json['id'] as String,
      clientId: json['client_id'] as String,
      freelancerId: json['freelancer_id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      category: json['category'] as String?,
      attachments: json['attachments'] != null
          ? (json['attachments'] as List)
          .map((e) => AttachmentModel.fromJson(e))
          .toList()
          : [],
      serviceType: (json['service_type'] as String) == 'private'
          ? ServiceType.private
          : ServiceType.public,
      budget: (json['budget'] as num?)?.toDouble(),

      status: _orderStatusFromString(json['status'] as String?),
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      offersCount: json['offers_count'] as int,
      workStartedAt: json['work_started'] != null
          ? DateTime.parse(json['work_started'] as String)
          : null,
       completedAt:  json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
           : null,
      paymentConfirmedAt:  json['payment_confirmed'] != null
          ? DateTime.parse(json['payment_confirmed'] as String)
          : null,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_id': clientId,
      'freelancer_id': freelancerId,
      'title': title,
      'description': description,
      'category': category,
      'attachments': attachments.map((e) => e.toJson()).toList(),
      'service_type': serviceType == ServiceType.private ? 'private' : 'public',
      'budget': budget,
      'status': _orderStatusToString(status),
      'deadline': deadline?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'offers_count': offersCount,
      'work_started': workStartedAt?.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
      'payment_confirmed': paymentConfirmedAt?.toIso8601String(),

    };
  }

  static OrderStatus _orderStatusFromString(String? status) {
    switch (status) {
      case 'Accepted':
        return OrderStatus.Accepted;
      case 'AwaitingPaymentConfirmation':
        return OrderStatus.Waiting;
      case 'Paid':
        return OrderStatus.Paid;
      case 'In Progress':
        return OrderStatus.InProgress;
      case 'Waiting':
        return OrderStatus.Waiting;

      case 'Completed':
        return OrderStatus.Completed;
      case 'Cancelled':
        return OrderStatus.Cancelled;
      default:
        return OrderStatus.Pending;
    }
  }

  static String _orderStatusToString(OrderStatus status) {
    switch (status) {
      case OrderStatus.Accepted:
        return 'Accepted';
      case OrderStatus.Waiting:
        return 'Waiting';
      case OrderStatus.Paid:
        return 'Paid';
      case OrderStatus.InProgress:
        return 'In Progress';
      case OrderStatus.Completed:
        return 'Completed';
      case OrderStatus.Cancelled:
        return 'Cancelled';
      default:
        return 'Pending';
    }
  }

  static OrderDm fromEntity(OrderEntity entity) {
    return OrderDm(
      id: entity.id,
      clientId: entity.clientId,
      freelancerId: entity.freelancerId,
      title: entity.title,
      category: entity.category,
      description: entity.description,
      attachments: entity.attachments,
      serviceType: entity.serviceType,
      budget: entity.budget,
      status: entity.status,
      deadline: entity.deadline,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      offersCount: entity.offersCount,
      workStartedAt: entity.workStartedAt,
      completedAt: entity.completedAt,
      paymentConfirmedAt: entity.paymentConfirmedAt,
    );
  }
  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      clientId: clientId,
      freelancerId: freelancerId,
      title: title,
      description: description,
      category: category,
      attachments: attachments,
      serviceType: serviceType,
      budget: budget,
      status: status,
      deadline: deadline,
      createdAt: createdAt,
      updatedAt: updatedAt,
      offersCount: offersCount,
      workStartedAt: workStartedAt,
      completedAt: completedAt,
      paymentConfirmedAt: paymentConfirmedAt,

    );
  }
}
