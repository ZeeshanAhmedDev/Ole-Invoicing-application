import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';

class ControllersTextFields {
  static final ControllersTextFields _singleton =
      ControllersTextFields._internal();
  ControllersTextFields._internal();
  static ControllersTextFields get instance => _singleton;

  //==================== Create Invoice Controller ==================Start
  var clientNameController = TextEditingController();
  var clientInvoiceDateController = TextEditingController();
  var invoiceNoController = TextEditingController();
  //==================== Create Invoice Controller ==================END

  //==================== Edit Client Controller ==================Start
  var companyControllerLogin = TextEditingController();
  var userNameControllerLogin = TextEditingController();
  var passwordControllerLogin = TextEditingController();
  var useWorkCategoryControllerLogin = TextEditingController();
//==================== Edit Client Controller ==================END

  //==================== Add Client Controller ==================Start
  var clientNameAddClientController = TextEditingController();
  var clientAddressAddClientController = TextEditingController();
  var clientPhoneNoAddClientController = TextEditingController();
//==================== Add Client Controller ==================END

  //==================== Add Client Controller ==================Start
  var clientNameAddDescriptionController = TextEditingController();
  var costCodeAddDescriptionController = MaskedTextController(mask: '000-000');

//==================== Add Client Controller ==================END

  //==================== Edit Worker Controller ==================Start
  var workerClientName = TextEditingController();
  var workerClientAddress = TextEditingController();
  var workerClientPhone = TextEditingController();
}
