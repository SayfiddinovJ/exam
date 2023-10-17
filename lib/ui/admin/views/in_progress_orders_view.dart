import 'package:coffee_shop/data/models/order/order_model.dart';
import 'package:coffee_shop/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class InProgressOrdersView extends StatelessWidget {
  const InProgressOrdersView({super.key, required this.orders});

  final List<OrderModel> orders;

  @override
  Widget build(BuildContext context) {
    return orders.isEmpty
        ? const Center(
            child: Text(
              'Your have no orders yet',
              style: TextStyle(color: AppColors.white),
            ),
          )
        : ListView(
            children: [
              ...List.generate(
                orders.length,
                (index) {
                  OrderModel order = orders[index];
                  return ListTile(
                    title: Text(
                      order.phone,
                      style: const TextStyle(color: AppColors.white),
                    ),
                    subtitle: Text(
                      order.status,
                      style: const TextStyle(color: AppColors.white),
                    ),
                  );
                },
              )
            ],
          );
  }
}
