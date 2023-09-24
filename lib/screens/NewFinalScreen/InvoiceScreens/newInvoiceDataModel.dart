import '../SelectCategories/selectCategoriesModel.dart';

class DataModelForInvoice {
  var weekEndingDate, name, invoiceNumber, totalIndex;
  List<CheckBoxSettingsForCategoriesModel> checkBoxSettingsForCategoriesModel =
      [];

  DataModelForInvoice(
    this.weekEndingDate,
    this.name,
    this.invoiceNumber,
    this.totalIndex,
    this.checkBoxSettingsForCategoriesModel,
  );
}
