// report 50070 "Barcode Report 1"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './BarcodeReport1.rdlc';

//     dataset
//     {
//         dataitem(Integer; Integer)
//         {
//             DataItemTableView = SORTING(Number)
//                                 ORDER(Ascending);
//             column(BarcodeNo; cdBarcodeNo)
//             {
//             }
//             column(Barcode; txtBarCode)
//             {
//             }
//             column(BarcodeNo1; cdBarcodeNo1)
//             {
//             }
//             column(Barcode1; txtBarCode1)
//             {
//             }
//             column(QRCode; recBarCode."QR Code")
//             {
//             }
//             column(QRCode1; recBarCode."QR Code 1")
//             {
//             }
//             column(QRCode2; recBarCode."QR Code 2")
//             {
//             }
//             column(Item; txtBarCode)
//             {
//             }
//             column(Item1; txtBarCode1)
//             {
//             }
//             column(Item2; txtBarCode2)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin

//                 txtBarCode := '';
//                 txtBarCode1 := '';
//                 txtBarCode2 := '';

//                 recBarCode.RESET;
//                 recBarCode.DELETEALL;
//                 recBarCode.INIT;

//                 IF Integer.Number > 1 THEN BEGIN
//                     recBarCodesLoop.RESET;
//                     recBarCodesLoop.FINDFIRST;
//                     recBarCodesLoop.DELETE;
//                 END;

//                 recBarCodesLoop.RESET;
//                 recBarCodesLoop.FINDFIRST;
//                 txtBarCodeText := recBarCodesLoop."FBT Group Code" + recBarCodesLoop."Document No." + FORMAT(recBarCodesLoop."FBT Header Entry No.") +
//                                                   recBarCodesLoop."G/L Account No." + recBarCodesLoop."External Document No." + FORMAT(recBarCodesLoop."Value %");
//                 cuGSTEInvoice.CreateQRCode(txtBarCodeText, recTempBlob);
//                 recBarCode."QR Code" := recTempBlob.Blob;
//                 txtBarCode := recBarCodesLoop."G/L Account No." + ' - ' + recBarCodesLoop."External Document No.";
//                 intEntryNo := intEntryNo - 1;

//                 IF intEntryNo <> 0 THEN BEGIN
//                     recBarCodesLoop.DELETE;

//                     recBarCodesLoop.RESET;
//                     recBarCodesLoop.FINDFIRST;
//                     txtBarCodeText := recBarCodesLoop."FBT Group Code" + recBarCodesLoop."Document No." + FORMAT(recBarCodesLoop."FBT Header Entry No.") +
//                                                       recBarCodesLoop."G/L Account No." + recBarCodesLoop."External Document No." + FORMAT(recBarCodesLoop."Value %");
//                     cuGSTEInvoice.CreateQRCode(txtBarCodeText, recTempBlob);
//                     recBarCode."QR Code 1" := recTempBlob.Blob;
//                     txtBarCode1 := recBarCodesLoop."G/L Account No." + ' - ' + recBarCodesLoop."External Document No.";
//                     intEntryNo := intEntryNo - 1;
//                 END;

//                 IF intEntryNo <> 0 THEN BEGIN
//                     recBarCodesLoop.DELETE;

//                     recBarCodesLoop.RESET;
//                     recBarCodesLoop.FINDFIRST;
//                     txtBarCodeText := recBarCodesLoop."FBT Group Code" + recBarCodesLoop."Document No." + FORMAT(recBarCodesLoop."FBT Header Entry No.") +
//                                                       recBarCodesLoop."G/L Account No." + recBarCodesLoop."External Document No." + FORMAT(recBarCodesLoop."Value %");
//                     cuGSTEInvoice.CreateQRCode(txtBarCodeText, recTempBlob);
//                     recBarCode."QR Code 2" := recTempBlob.Blob;
//                     txtBarCode2 := recBarCodesLoop."G/L Account No." + ' - ' + recBarCodesLoop."External Document No.";
//                     intEntryNo := intEntryNo - 1;
//                 END;

//                 /*
//                 cdBarcodeNo := '';
//                 txtBarCode := '';
//                 cdBarcodeNo1 := '';
//                 txtBarCode1 := '';

//                 IF Integer.Number > 1 THEN BEGIN
//                   recBarCodes.RESET;
//                   recBarCodes.FINDFIRST;
//                   recBarCodes.DELETE;
//                 END;

//                 recBarCodes.RESET;
//                 recBarCodes.FINDFIRST;
//                 cdBarcodeNo := recBarCodes.Description;
//                 txtBarCode := recBarCodes.Description;

//                 IF recBarCodes."Entry No." <> intEntryNo THEN BEGIN
//                   recBarCodes.DELETE;

//                   recBarCodes.RESET;
//                   recBarCodes.FINDFIRST;
//                   cdBarcodeNo1 := recBarCodes.Description;
//                   txtBarCode1 := recBarCodes.Description;
//                 END;
//                 */

//             end;

//             trigger OnPreDataItem()
//             begin

//                 recBarCodesLoop.RESET;
//                 recBarCodesLoop.DELETEALL;
//                 intEntryNo := 0;

//                 /*
//                 recRecevingLines.RESET;
//                 recRecevingLines.SETRANGE("Document No.", cdReceivingNo);
//                 recRecevingLines.SETFILTER("Receive Qty", '<>%1', 0);
//                 recRecevingLines.FINDFIRST;
//                 REPEAT
//                   recReservationEntry.RESET;
//                   recReservationEntry.SETRANGE("Source Type", 50018);
//                   recReservationEntry.SETRANGE("Source Subtype", 0);
//                   recReservationEntry.SETRANGE("Source ID", recRecevingLines."Document No.");
//                   recReservationEntry.SETRANGE("Source Ref. No.", recRecevingLines."Line No.");
//                   recReservationEntry.FINDFIRST;
//                   REPEAT
//                     FOR intLoopCounter := 1 TO recReservationEntry."Quantity (Base)" DO BEGIN
//                       recBarCodes.INIT;
//                       intEntryNo += 1;
//                       recBarCodes."Entry No." := intEntryNo;
//                       recBarCodes.Description := recRecevingLines."Item No." + '/' + recReservationEntry."Lot No.";
//                       recBarCodes.INSERT;
//                     END;
//                   UNTIL recReservationEntry.NEXT = 0;
//                 UNTIL recRecevingLines.NEXT = 0;
//                 */
//                 recBarCodeLines.RESET;
//                 recBarCodeLines.SETRANGE("Receiving No.", cdReceivingNo);
//                 recBarCodeLines.FINDFIRST;
//                 REPEAT
//                     FOR intLoopCounter := 1 TO recBarCodeLines.Quantity DO BEGIN
//                         recBarCodesLoop.INIT;
//                         intEntryNo += 1;
//                         recBarCodesLoop."Entry No." := intEntryNo;
//                         recBarCodesLoop."FBT Group Code" := recBarCodeLines."Bar Code ID";
//                         recBarCodesLoop."Document No." := recBarCodeLines."Purchase Order No.";
//                         recBarCodesLoop."FBT Header Entry No." := recBarCodeLines."Purchase Order Line No.";
//                         recBarCodesLoop."G/L Account No." := recBarCodeLines."Item No.";
//                         recBarCodesLoop."External Document No." := recBarCodeLines."Lot No.";
//                         recBarCodesLoop."Value %" := recBarCodeLines.Quantity;
//                         recBarCodesLoop.Description := recBarCodeLines."Bar Code";
//                         recBarCodesLoop.INSERT;
//                     END;
//                 UNTIL recBarCodeLines.NEXT = 0;

//                 intLoopCounter := ROUND(intEntryNo / 3, 1, '>');
//                 Integer.SETRANGE(Number, 1, intLoopCounter);

//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     var
//         cdReceivingNo: Code[20];
//         recRecevingLines: Record 50018;
//         recReservationEntry: Record 337;
//         recBarCodesLoop: Record 16541 temporary;
//         intEntryNo: Integer;
//         cdBarcodeNo: Code[50];
//         txtBarCode: Text[50];
//         cdBarcodeNo1: Code[50];
//         txtBarCode1: Text[50];
//         intLoopCounter: Integer;
//         recBarCodeLines: Record 50019;
//         recBarCode: Record 50019 temporary;
//         recTempBlob: Record 99008535;
//         cuGSTEInvoice: Codeunit 50018;
//         txtBarCodeText: Text;
//         txtBarCode2: Text[50];


//     procedure SetRecevingNo(ReceivingNo: Code[20])
//     begin

//         cdReceivingNo := ReceivingNo;
//     end;
// }

