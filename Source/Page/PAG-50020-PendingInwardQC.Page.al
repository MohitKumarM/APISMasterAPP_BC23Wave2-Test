page 50020 "Pending Inward QC"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Permissions = TableData "Item Ledger Entry" = rm;
    SourceTable = "Item Ledger Entry";
    SourceTableView = SORTING("Item No.", "Posting Date")
                      ORDER(Ascending)
                      WHERE("Entry Type" = FILTER('Purchase'),
                            "Document Type" = FILTER('Purchase Receipt'),
                            "Quality Checked" = const(false),
                            "QC To Approve" = const(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field(Flora; Rec.Flora)
                {
                    ApplicationArea = All;
                }
                field("Quality Checked"; Rec."Quality Checked")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Quality Check")
            {
                Caption = 'Quality Check';
                Image = TestReport;
                Promoted = true;

                trigger OnAction()
                begin
                    recInventorySetup.GET;
                    recInventorySetup.TESTFIELD("Quality Nos.");

                    recQualityCheck.RESET;
                    recQualityCheck.SETRANGE("Document Type", recQualityCheck."Document Type"::"Purchase Receipt");
                    recQualityCheck.SETRANGE("Document No.", Rec."Document No.");
                    recQualityCheck.SETRANGE("Document Line No.", Rec."Document Line No.");
                    recQualityCheck.SETRANGE("Lot No.", Rec."Lot No.");
                    IF NOT recQualityCheck.FINDFIRST THEN BEGIN
                        cdDocNo := cuNoSeries.GetNextNo(recInventorySetup."Quality Nos.", TODAY, TRUE);

                        recItem.GET(Rec."Item No.");
                        recItem.TESTFIELD("Quality Process");

                        recQualityCheck.INIT;
                        recQualityCheck."No." := cdDocNo;
                        recQualityCheck.Date := TODAY;
                        recQualityCheck."Document Type" := recQualityCheck."Document Type"::"Purchase Receipt";
                        recQualityCheck."Document No." := Rec."Document No.";
                        recQualityCheck."Document Line No." := Rec."Document Line No.";
                        recQualityCheck.Quantity := Rec.Quantity;
                        recQualityCheck."Item Code" := Rec."Item No.";
                        recQualityCheck."Item Name" := recItem.Description;
                        recQualityCheck."Lot No." := Rec."Lot No.";
                        recQualityCheck.INSERT;

                        intLineNo := 0;
                        recQualityMeasure.RESET;
                        recQualityMeasure.SETRANGE("Standard Task Code", recItem."Quality Process");
                        IF recQualityMeasure.FINDFIRST THEN begin
                            REPEAT
                                recQualityLines.INIT;
                                recQualityLines."QC No." := cdDocNo;
                                intLineNo += 10000;
                                recQualityLines."Line No." := intLineNo;
                                recQualityLines."Lot No." := '';
                                recQualityLines."Quality Process" := recQualityMeasure."Standard Task Code";
                                recQualityLines."Quality Measure" := recQualityMeasure."Qlty Measure Code";
                                recQualityLines.Parameter := recQualityMeasure.Parameter;
                                recQualityLines.Specs := recQualityMeasure.Specs;
                                recQualityLines.Limit := recQualityMeasure.Limit;
                                recQualityLines.INSERT;
                            UNTIL recQualityMeasure.NEXT = 0
                        end
                        ELSE
                            ERROR('Quality measures is not configured on the item.');
                    END;

                    recQualityCheck.RESET;
                    recQualityCheck.SETRANGE("Document Type", recQualityCheck."Document Type"::"Purchase Receipt");
                    recQualityCheck.SETRANGE("Document No.", Rec."Document No.");
                    recQualityCheck.SETRANGE("Document Line No.", Rec."Document Line No.");
                    recQualityCheck.SETRANGE("Lot No.", Rec."Lot No.");

                    CLEAR(pgQuality);
                    pgQuality.SETTABLEVIEW(recQualityCheck);
                    pgQuality.RUN;
                end;
            }
            action("Close QC")
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF NOT CONFIRM('Do you want to close the QC forcefully?', FALSE) THEN
                        EXIT;

                    recItemLedger.GET(Rec."Entry No.");
                    recItemLedger."Quality Checked" := TRUE;
                    recItemLedger.MODIFY;
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    var
        recInventorySetup: Record "Inventory Setup";
        recQualityCheck: Record "Quality Header";
        cdDocNo: Code[20];
        cuNoSeries: Codeunit NoSeriesManagement;
        recItem: Record Item;
        intLineNo: Integer;
        recQualityMeasure: Record "Standard Task Quality Measure";
        recQualityLines: Record "Quality Line";
        pgQuality: Page "Quality Check Card";
        recItemLedger: Record "Item Ledger Entry";
}
