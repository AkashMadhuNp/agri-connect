import 'package:agri/core/utils/app_dimensions.dart';
import 'package:flutter/material.dart';


class LoadingWidget extends StatelessWidget {
  final String message;
  
  const LoadingWidget({
    super.key,
    this.message = 'Loading...',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: AppDimensions.paddingLarge),
          Text(message),
        ],
      ),
    );
  }
}
