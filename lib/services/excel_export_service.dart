import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:whale_stock/models/product.dart';

class ExcelExportService {
  Future<String?> exportProducts(List<Product> products) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Inventory'];


    sheetObject.appendRow([
      TextCellValue('ID'),
      TextCellValue('Name'),
      TextCellValue('SKU'),
      TextCellValue('Price'),
      TextCellValue('Quantity'),
    ]);


    for (var product in products) {
      sheetObject.appendRow([
        TextCellValue(product.id),
        TextCellValue(product.name),
        TextCellValue(product.sku),
        DoubleCellValue(product.price),
        IntCellValue(product.quantity),
      ]);
    }

    final directory = await getApplicationDocumentsDirectory();
    final String fileName =
        "Inventory_Export_${DateTime.now().millisecondsSinceEpoch}.xlsx";
    final String filePath = p.join(directory.path, fileName);

    final List<int>? fileBytes = excel.save();
    if (fileBytes != null) {
      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes);
      return filePath;
    }
    return null;
  }
}
