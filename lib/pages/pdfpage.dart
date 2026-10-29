import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:famoo/classes.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key, required this.item, required this.data});
  final Item item;
  final data;

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  double lh() {
    switch (widget.item.type) {
      case "dress":
        return 170;

      case "jacket":
        return 208;

      case "pants":
        return 490;

      default:
        return 170;
    }
  }

  Future<Uint8List> pdfg() async {
    final pdf = pw.Document(
      title: "${widget.item.name} Card",
      subject: "Size Chart",
      creator: "Aya",
      producer: "Aya Size Chart",
    );

    final ttf = await fontFromAssetBundle('assets/fonts/pinkyfont.ttf');
    final image = widget.item.img != null
        ? pw.MemoryImage(File(widget.item.img!.path).readAsBytesSync())
        : null;

    pdf.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          theme: pw.ThemeData(defaultTextStyle: pw.TextStyle(font: ttf)),
        ),
        build: (context) {
          return pw.FullPage(
            ignoreMargins: true,
            child: pw.Container(
              decoration: pw.BoxDecoration(
                color: PdfColor(249 / 255, 246 / 255, 242 / 255),
              ),
              child: pw.Container(
                margin: pw.EdgeInsets.only(
                  top: 30,
                  right: 30,
                  left: 30,
                  bottom: image != null ? 100 : 400,
                ),
                padding: const pw.EdgeInsets.all(15),

                decoration: pw.BoxDecoration(
                  color: PdfColors.white,
                  borderRadius: pw.BorderRadius.circular(12),
                  border: pw.Border.all(
                    width: 1.8,
                    color: PdfColor(230 / 255, 219 / 255, 205 / 255),
                  ),
                ),
                child: pw.Column(
                  children: [
                    pw.Text(
                      "AYA ELFAKHRANY",
                      style: pw.TextStyle(
                        font: ttf,
                        fontSize: 19,
                        color: PdfColor(196 / 255, 160 / 255, 89 / 255),
                      ),
                    ),

                    pw.Text("Size Chart Data"),

                    pw.Padding(
                      padding: pw.EdgeInsets.symmetric(horizontal: 8),
                      child: pw.Divider(color: PdfColor.fromHex("#c4a059")),
                    ),

                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        if (widget.item.img != null)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                "|Image",
                                style: pw.TextStyle(
                                  color: PdfColor.fromHex("#c4a059"),
                                  fontSize: 17,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.center,
                                margin: pw.EdgeInsets.symmetric(vertical: 7),
                                padding: pw.EdgeInsets.all(5),
                                width: 200,
                                height: 240,
                                decoration: pw.BoxDecoration(
                                  borderRadius: pw.BorderRadius.circular(8),
                                  color: PdfColor.fromHex("#fdfbf6"),
                                  border: pw.Border.all(
                                    style: pw.BorderStyle.dashed,
                                    color: PdfColor(
                                      196 / 255,
                                      160 / 255,
                                      89 / 255,
                                    ),
                                  ),
                                ),
                                child: (image != null)
                                    ? pw.Expanded(child: pw.Image(image))
                                    : null,
                              ),
                            ],
                          ),

                        pw.SizedBox(width: 20),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "|Clint Data",
                              style: pw.TextStyle(
                                color: PdfColor.fromHex("#c4a059"),
                                fontSize: 17,
                              ),
                            ),
                            pw.Container(
                              margin: pw.EdgeInsets.only(top: 5),
                              // width: 300,
                              // height: 300,
                              child: pw.Column(
                                children: [
                                  pw.Row(
                                    children: [
                                      pw.Expanded(
                                        child: infoCard(
                                          title: "Clint name",
                                          value: widget.item.name,
                                          font: ttf,
                                        ),
                                      ),

                                      pw.SizedBox(width: 10),

                                      pw.Expanded(
                                        child: infoCard(
                                          title: "Phone number",
                                          value: widget.item.fonenumber
                                              .toString(),
                                          font: ttf,
                                        ),
                                      ),
                                    ],
                                  ),

                                  pw.SizedBox(height: 10),

                                  pw.Row(
                                    children: [
                                      pw.Expanded(
                                        child: infoCard(
                                          title: "Dead date",
                                          value:
                                              "${widget.item.date.year}-${widget.item.date.month.toString().padLeft(2, '0')}-${widget.item.date.day.toString().padLeft(2, '0')}",
                                          font: ttf,
                                        ),
                                      ),

                                      pw.SizedBox(width: 10),

                                      pw.Expanded(
                                        child: infoCard(
                                          title: "ID number",
                                          value: widget.item.id.toString(),
                                          font: ttf,
                                        ),
                                      ),
                                    ],
                                  ),

                                  pw.SizedBox(height: 10),

                                  pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      if (widget.item.note != '' ||
                                          widget.item.note != null)
                                        pw.Expanded(
                                          child: infoCard(
                                            title: "Note",
                                            value: widget.item.note!,
                                            font: ttf,
                                          ),
                                        ),
                                      pw.SizedBox(width: 10),
                                      pw.Expanded(
                                        child: infoCard(
                                          title: "Order type",
                                          value: widget.item.type,
                                          font: ttf,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

    pdf.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          theme: pw.ThemeData(defaultTextStyle: pw.TextStyle(font: ttf)),
        ),
        build: (context) {
          return pw.FullPage(
            ignoreMargins: true,
            child: pw.Container(
              decoration: pw.BoxDecoration(
                color: PdfColor(249 / 255, 246 / 255, 242 / 255),
              ),
              child: pw.Container(
                margin: pw.EdgeInsets.only(
                  top: 30,
                  right: 30,
                  left: 30,
                  bottom: lh(),
                ),
                padding: pw.EdgeInsets.all(15),
                decoration: pw.BoxDecoration(
                  color: PdfColors.white,
                  borderRadius: pw.BorderRadius.circular(12),
                  border: pw.Border.all(
                    width: 1.8,
                    color: PdfColor(230 / 255, 219 / 255, 205 / 255),
                  ),
                ),
                child: pw.Container(
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.black, width: 2),
                    borderRadius: pw.BorderRadius.circular(12),
                  ),
                  child: pw.ClipRRect(
                    horizontalRadius: 12,
                    verticalRadius: 12,
                    child: pw.Table(
                      columnWidths: {
                        0: const pw.FlexColumnWidth(2),
                        1: const pw.FlexColumnWidth(1),
                      },
                      border: pw.TableBorder.all(
                        color: PdfColor(230 / 255, 219 / 255, 205 / 255),
                      ),
                      children: [
                        pw.TableRow(
                          decoration: pw.BoxDecoration(
                            color: PdfColor(196 / 255, 160 / 255, 89 / 255),
                          ),
                          children: [
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(
                                "Measurements",
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                  font: ttf,
                                  color: PdfColors.white,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(
                                "CM",
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                  font: ttf,
                                  color: PdfColors.white,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        ...List.generate(widget.data.length, (i) {
                          final entry = widget.data.entries.elementAt(i);

                          return pw.TableRow(
                            decoration: pw.BoxDecoration(
                              color: i.isEven
                                  ? PdfColors.white
                                  : PdfColor(253 / 255, 251 / 255, 246 / 255),
                            ),
                            children: [
                              pw.Padding(
                                padding: const pw.EdgeInsets.all(8),
                                child: pw.Text(entry.key),
                              ),
                              pw.Padding(
                                padding: const pw.EdgeInsets.all(8),
                                child: pw.Text(entry.value.toString()),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );

    return await pdf.save();
  }

  Future<void> sharePdf() async {
    final Uint8List bytes = await pdfg();

    await Printing.sharePdf(
      bytes: bytes,
      filename: '${widget.item.name} card-${widget.item.id}.pdf',
    );
  }

  Future<void> savePdf() async {
    final Uint8List bytes = await pdfg();

    FilePicker.saveFile(
      dialogTitle: 'Save PDF',
      fileName: '${widget.item.name} card-${widget.item.id}.pdf',
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      bytes: bytes,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("PDF Page"),
      ),
      body: PdfPreview(
        actions: [
          IconButton(
            onPressed: () {
              sharePdf();
            },
            icon: Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {
              savePdf();
            },
            icon: Icon(Icons.download_for_offline, size: 28),
          ),
        ],
        allowSharing: false,
        canChangeOrientation: false,
        canChangePageFormat: false,
        build: (format) => pdfg(),
      ),
    );
  }
}

pw.Widget infoCard({
  required String title,
  required String value,
  required pw.Font font,
}) {
  return pw.Container(
    padding: const pw.EdgeInsets.all(10),
    decoration: pw.BoxDecoration(
      color: PdfColor(248 / 255, 245 / 255, 241 / 255),
      border: pw.Border.all(color: PdfColor(224 / 255, 212 / 255, 196 / 255)),
    ),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            font: font,
            fontSize: 11,
            color: PdfColors.grey700,
          ),
        ),

        pw.SizedBox(height: 5),

        pw.Text(
          value,
          textAlign: pw.TextAlign.right,
          style: pw.TextStyle(
            font: font,
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.black,
          ),
        ),
      ],
    ),
  );
}
