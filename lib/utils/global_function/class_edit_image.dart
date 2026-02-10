// ignore_for_file: must_be_immutable

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pro_image_editor/pro_image_editor.dart';

class FullImageEditorScreen extends StatefulWidget {
  final File imageFile;
  bool isShops;
  bool isProfile;

  FullImageEditorScreen({
    super.key,
    required this.imageFile,
    this.isShops = false,
    this.isProfile = false,
  });

  @override
  State<FullImageEditorScreen> createState() => _FullImageEditorScreenState();
}

class _FullImageEditorScreenState extends State<FullImageEditorScreen> {
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
    _loadImageBytes();
  }

  Future<void> _loadImageBytes() async {
    imageBytes = await widget.imageFile.readAsBytes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (imageBytes == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return ProImageEditor.memory(
      imageBytes!,
      callbacks: ProImageEditorCallbacks(
        onImageEditingComplete: (Uint8List editedBytes) async {
          final Uint8List resizedBytes;
          if (widget.isShops) {
            resizedBytes = editedBytes;
          } else if (widget.isProfile) {
            resizedBytes = editedBytes;
          } else {
            resizedBytes = editedBytes;
          }

          Navigator.pop(context, resizedBytes);
        },

        // onCloseEditor: (EditorMode editMode) {
        //   Navigator.pop(context, null);
        // },
      ),
      configs: ProImageEditorConfigs(
        cropRotateEditor:
            widget.isShops
                ? const CropRotateEditorConfigs(
                  initAspectRatio: 16.0 / 9.0,
                  showAspectRatioButton: false,
                )
                : widget.isProfile
                ? const CropRotateEditorConfigs()
                : const CropRotateEditorConfigs(
              initAspectRatio: 3.0 / 4.0,
              showAspectRatioButton: false,
            ),
      ),
    );
  }
}
