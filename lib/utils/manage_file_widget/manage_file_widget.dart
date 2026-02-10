import 'dart:io';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:flutter/material.dart';

import '../widget/dashed_border.dart';

class AnimatedImagePickerFormField extends StatelessWidget {
  final File? image;
  final bool isLoading;
  final double height;
  final double width;
  final String label;
  final VoidCallback onPickImage;
  final VoidCallback onRemoveImage;
  final String? Function(File?) validator;
  final String? urlImage;
  const AnimatedImagePickerFormField({
    super.key,
    required this.image,
    required this.isLoading,
    required this.onPickImage,
    required this.onRemoveImage,
    required this.validator,
    required this.height,
    required this.width,
     this.urlImage,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<File?>(
      validator: (_) => validator(image),
      initialValue: image,
      builder: (formState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: Tween<double>(
                      begin: 0.95,
                      end: 1,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child:
                  image == null && urlImage == null  
                      ? _UploadView(
                        key: const ValueKey("upload"),
                        isLoading: isLoading,
                        label: label,
                        height: height,
                        width: width,
                        onPickImage: onPickImage,
                      )
                      : _PreviewView(
                        key: const ValueKey("preview"),
                        image: image,
                        urlImage: urlImage,
                        height: height,
                        width: width,
                        onRemoveImage: onRemoveImage,
                      ),
            ),

            /// Error message
            if (formState.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  formState.errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _UploadView extends StatelessWidget {
  final bool isLoading;
  final String label;
  final double height;
  final double width;
  final VoidCallback onPickImage;

  const _UploadView({
    super.key,
    required this.isLoading,
    required this.label,
    required this.height,
    required this.width,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return DashedBorderContainer(
      child: SizedBox(
        height: height,
        width: width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLoading
                  ? const LoadingUi()
                  : IconButton(
                    onPressed: onPickImage,
                    icon: const Icon(Icons.upload_file, size: 40),
                  ),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}

class _PreviewView extends StatelessWidget {
  final File  ?image;
  final double height;
  final double width;
  final VoidCallback onRemoveImage;
  final String? urlImage;
  const _PreviewView({
    super.key,
    required  this.image,
    required this.height,
    required this.width,
    required this.onRemoveImage,
    required this.urlImage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (urlImage != null && urlImage!.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              urlImage!,
              height: height,
              width: width,
              fit: BoxFit.contain,
            ),
          )
        else if(image!=null)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              image!,
              height: height,
              width: width,
              fit: BoxFit.contain,
            ),
          ),
         
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: onRemoveImage,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(6),
              child: const Icon(Icons.close, color: Colors.white, size: 18),
            ),
          ),
        ),
      ],
    );
  }
}
