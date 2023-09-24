import 'package:easy_localization/easy_localization.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ole_app/screens/NewFinalScreen/TimeSheetScreen/pdfGenerationForTimeSheet/PdfInvoiceApi.dart';
import 'package:ole_app/screens/NewFinalScreen/TimeSheetScreen/pdfGenerationForTimeSheet/fileHandler.dart';
import 'package:ole_app/screens/NewFinalScreen/TimeSheetScreen/time_sheet_screen.dart';
import '../../../custom_widgets/Container_btn_with_gradient.dart';
import '../../../custom_widgets/appbar.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../utils/controllers.dart';
import '../../../utils/helper.dart';
import 'pdfGenerationForTimeSheet/data model.dart';

class TimeSheetPreviewScreen extends StatefulWidget {
  var name,
      startTime,
      endTime,
      showDate,
      decription,
      // showTime,
      perHourRate,
      suppliesAmount;

  final int totalLength;
  TimeSheetPreviewScreen({
    Key? key,
    this.name,
    this.startTime,
    this.endTime,
    this.showDate,
    this.decription,
    // this.showTime,
    this.perHourRate,
    this.suppliesAmount,
    required this.totalLength,
  }) : super(key: key);

  @override
  _TimeSheetPreviewScreenState createState() => _TimeSheetPreviewScreenState();
}

class _TimeSheetPreviewScreenState extends State<TimeSheetPreviewScreen> {
  List<DataModelForTimeSheet> dataModelForTimeSheet = [];

  final hourlyRateController = MaskedTextController(mask: '000');
  // final suppliesAmount = MaskedTextController(mask: '000');

  final myStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 22.sp,
  );

  final myTotalStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 30.sp,
  );
  // var listItems = Helper.selectedItems.toString().replaceAll('[', '');
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Helper.onWillPopFunc(
        context: context,
        className: const TimeSheetScreen(),
      ),
      child: Scaffold(
        appBar: CustomAppBar(
            title: LocaleKeys.timeSheetPreview_txt.tr(),
            fun: () => Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => const TimeSheetScreen(),
                )),
            elevation: 0),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 30.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.details_txt.tr(),
                  style: myStyle,
                ),

                SizedBox(
                  height: 60.h,
                ),

                ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.totalLength,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    color: Colors.transparent,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    WidgetsBinding.instance?.addPostFrameCallback((_) {
                      Helper.index = index;
                      if (kDebugMode) {
                        print("index  =====>  " + index.toString());
                      }
                    });

                    return Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${LocaleKeys.name_txt.tr()}: ",
                              style: myStyle,
                            ),
                            Text("${widget.name}"),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "${LocaleKeys.startTime_txt.tr()}: ",
                              style: myStyle,
                            ),
                            Text("${widget.name}"),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "${LocaleKeys.endTime_txt.tr()}: ",
                              style: myStyle,
                            ),
                            // Text(
                            //   ControllersTextFields
                            //       .instance.invoiceNoController.text,
                            // ),
                            // Text("${widget.endTime}"),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "${LocaleKeys.date_txt.tr()}: ",
                              style: myStyle,
                            ),
                            Text(
                              DateFormat('dd-MM-yyyy').format(widget.showDate),
                              // "${DateTime.now()}",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "${LocaleKeys.description_txt.tr()}: ",
                              style: myStyle,
                            ),
                            Text(
                              widget.decription,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),

                        Helper.customSizedBox,
                        const Divider(
                          color: Colors.grey,
                        ),
                        // Helper.customSizedBox,
                      ],
                    );
                  },
                ),

                // ============================
                Row(
                  children: [
                    Text(
                      "${LocaleKeys.time_txt.tr()}: ",
                      style: myStyle,
                    ),
                    const Text("5.5 Hours"),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Text(
                      "${LocaleKeys.perHourRate_txt.tr()}: ",
                      style: myStyle,
                    ),
                    Text("\$${widget.perHourRate}"),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Text(
                      "Supplies Amount: ",
                      style: myStyle,
                    ),
                    Text("\$${widget.suppliesAmount}"),
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  children: [
                    Text(
                      "${LocaleKeys.total_txt.tr()}: ",
                      style: myTotalStyle,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Text(
                      "${LocaleKeys.totalTime_txt.tr()}: ",
                      style: myStyle,
                    ),
                    const Text(''),
                    // "${Helper.calcWorkHours(widget.startTime, widget.endTime)}"),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Text(
                      "${LocaleKeys.totalAmount_txt.tr()}: ",
                      style: myStyle,
                    ),
                    const Text(
                      '224',
                    ),
                    // "\$${Helper.calculateTotalAmount(double.tryParse(widget.startTime)!, double.tryParse(widget.endTime)!)} ")
                  ],
                ),
                // ============================
                SizedBox(
                  height: 100.h,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 180.h,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    CustomContainerButton(
                      text: LocaleKeys.downloadInvoice_text.tr(),
                      onPressed: () async {
                        Helper.showAllDataForEverything;

                        setState(() {});

                        // generate pdf file
                        // var name,
                        //     startTime,
                        //     endTime,
                        //     showDate,
                        //     decription,
                        //     // showTime,
                        //     perHourRate,
                        //     suppliesAmount;

                        dataModelForTimeSheet.add(DataModelForTimeSheet(
                            widget.endTime,
                            widget.name,
                            widget.name,
                            widget.name,
                            widget.name,
                            widget.name,
                            widget.decription,
                            "4",
                            "4",
                            "4",
                            "4",
                            widget.totalLength));

                        final pdfFile =
                            await PdfInvoiceApi.generate(dataModelForTimeSheet
                                // weekEndingDate: widget.showDate,
                                // name: widget.name,
                                // description: widget.decription,
                                // totalTime: widget.perHourRate,
                                // invoiceNo: ControllersTextFields
                                //     .instance.invoiceNoController.text);
                                );

                        // opening the pdf file
                        setState(() {
                          FileHandleApi.openFile(pdfFile);
                        });

                        // Helper.calcWorkHours(widget.startTime, widget.endTime);
                        // final date = DateTime.now();
                        // final dueDate = date.add(const Duration(days: 7));
                        // final invoice = Invoice(
                        //   supplier: Supplier(
                        //       name: "AHmed",
                        //       address: "karachi, johar town",
                        //       paymentInfo: "sddddddddd"),
                        //   customer: Customer(
                        //     name: "AHmed",
                        //     address: "karachi, johar town",
                        //   ),
                        //   info: InvoiceInfo(
                        //     date: date,
                        //     dueDate: dueDate,
                        //     description: "sddddddddddd",
                        //     number: "${DateTime.now().year}-9999",
                        //   ),
                        //   items: [
                        //     InvoiceItem(
                        //       description: "Coffe",
                        //       date: DateTime.now(),
                        //       quantity: 3,
                        //       vat: 0.19,
                        //       unitPrice: 5.99,
                        //     ),
                        //     InvoiceItem(
                        //       description: "Water",
                        //       date: DateTime.now(),
                        //       quantity: 3,
                        //       vat: 0.19,
                        //       unitPrice: 5.99,
                        //     ),
                        //     InvoiceItem(
                        //       description: "Orange",
                        //       date: DateTime.now(),
                        //       quantity: 3,
                        //       vat: 0.19,
                        //       unitPrice: 5.99,
                        //     ),
                        //   ],
                        // );
                        // final pdfFile = await PdfInvoiceApi.generate(invoice);
                        // PdfApi.openFile(pdfFile);\
                      },
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomContainerButton(
                      text: LocaleKeys.cancel_txt.tr(),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const TimeSheetScreen(),
                          ),
                        );
                      },
                      isActive: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future openFile(File file) async {
  //   final url = file.path;
  //
  //   await openFile.open(url);
  // }
}
