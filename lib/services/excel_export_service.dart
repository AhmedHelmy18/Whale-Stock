import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import '../models/report_models.dart';
import 'package:flutter/foundation.dart';

class ExcelExportService {
  static Future<String?> exportMostMovedItems(List<MostMovedItem> items) async {
    try {
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Most_Moved_Items'];
      excel.setDefaultSheet('Most_Moved_Items');

      // Add Headers
      sheetObject.appendRow([
        TextCellValue('Item ID'),
        TextCellValue('Item Name'),
        TextCellValue('Category'),
        TextCellValue('Total Movement (Units)'),
        TextCellValue('Current Stock'),
      ]);

      // Add Data
      for (var item in items) {
        sheetObject.appendRow([
          TextCellValue(item.itemId),
          TextCellValue(item.itemName),
          TextCellValue(item.category),
          IntCellValue(item.totalMovement),
          IntCellValue(item.currentStock),
        ]);
      }

      var fileBytes = excel.save();

      if (kIsWeb) {
        // Handle web download if necessary
        return 'Web export not fully implemented here';
      } else {
        Directory directory = await getApplicationDocumentsDirectory();
        String outputPath = '${directory.path}/most_moved_items_${DateTime.now().millisecondsSinceEpoch}.xlsx';

        File(outputPath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes!);

        return outputPath;
      }
    } catch (e) {
      debugPrint('Error exporting to Excel: $e');
      return null;
    }
  }
}
