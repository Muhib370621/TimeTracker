import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension IntExtension on int {
  double get width => (this / 390 * Get.width).roundToDouble();
  double get height => (this / 844 * Get.height).roundToDouble();
  SizedBox heightSizedBox() {
    return SizedBox(height: toDouble());
  }

  SizedBox widthSizedBox() {
    return SizedBox(width: toDouble());
  }
}

// NOTE: double extension
extension DoubleExtension on double {
  double get width => (this / 390 * Get.width).roundToDouble();
  double get height => (this / 844 * Get.height).roundToDouble();
  SizedBox heightSizedBox() {
    return SizedBox(height: this);
  }

  SizedBox widthSizedBox() {
    return SizedBox(width: this);
  }
}

// NOTE: num extension
extension NumExtension on num {
  double get w => (this / 390 * Get.width).roundToDouble();
  double get h => (this / 844 * Get.height).roundToDouble();
  SizedBox heightSizedBox() {
    return SizedBox(height: toDouble());
  }

  SizedBox widthSizedBox() {
    return SizedBox(width: toDouble());
  }
}


extension StringExtension on String {
  DateTime? toDate({String formatString = "ddMMMYYY"}) {
    try {
      final format = DateFormat();
      format.addPattern(formatString);
      return format.parse(this);
    } catch (e) {}
    return null;
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension DateExtension on DateTime {
  String? toStringWithFormat({String formatString = "ddMMMYYY"}) {
    try {
      final format = DateFormat();
      format.addPattern(formatString);
      return format.format(this);
    } catch (e) {}
    return null;
  }
}

// extension FileExtension on File {
//   Future<Uint8List?> compressFile() async {
//     var result = await FlutterImageCompress.compressWithFile(
//       absolute.path,
//       quality: 40,
//     );
//     return result;
//   }
// }

extension TextExtension on Text {
  static Widget noData(String title) {
    return Center(
      child: Text(title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 16.0,
          )),
    );
  }
}
