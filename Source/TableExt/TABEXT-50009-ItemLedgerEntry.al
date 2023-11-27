tableextension 50009 ItemLedgerEntry extends "Item Ledger Entry"
{
    fields
    {
        field(50000; "MRP Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Deal No."; Code[20])
        {
            TableRelation = "Deal Master" WHERE(Status = FILTER(Release));
        }
        field(50002; "Packing Type"; Option)
        {
            OptionCaption = ' ,Drums,Tins,Buckets,Cans';
            OptionMembers = " ",Drums,Tins,Buckets,Cans;
        }
        field(50026; "Can"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Qty. in Pack"; Decimal)
        {
        }

        field(50004; "Deal Line No."; Integer)
        {
            TableRelation = "Deal Dispatch Details"."Line No." WHERE("Sauda No." = FIELD("Deal No."),
                                                                      "GAN Created" = FILTER(false));
        }
        field(50005; "Dispatched Qty. in Kg."; Decimal)
        {
            Editable = false;
        }
        field(50006; Flora; Code[20])
        {
            Editable = false;
            TableRelation = "New Product Group".Code WHERE("Item Category Code" = FILTER(''));
        }
        field(50008; "QC To Approve"; Boolean)
        {
        }
        field(50010; "Vehicle No."; Code[20])
        {
        }
        field(50011; "Purchaser Code"; Code[20])
        {
        }
        field(50012; "Purchaser Name"; Text[50])
        {
        }
        field(50020; "Tin"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Drum"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Bucket"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "MFG. Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Barcode Generated"; Boolean)
        {

        }
        field(60000; "Approved Quantity"; Decimal)
        {
        }
        field(60001; "Rejected Quantity"; Decimal)
        {
        }
        field(60002; "Quality Checked"; Boolean)
        {
        }
        field(70000; "Moisture (%)"; Text[10])
        {
        }
        field(70001; "Color (MM)"; Text[10])
        {
        }
        field(70002; "HMF (PPM)"; Text[10])
        {
        }
        field(70003; TRS; Text[10])
        {
        }
        field(70004; Sucrose; Text[10])
        {
        }
        field(70005; FG; Text[10])
        {
        }

    }
}