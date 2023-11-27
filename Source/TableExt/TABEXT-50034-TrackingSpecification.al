tableextension 50034 TrackingSpecfication extends "Tracking Specification"
{
    fields
    {
        field(50000; "MRP Price"; Decimal)
        {
            DataClassification = ToBeClassified;
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
        field(50026; "Can"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "ILE No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key20; "ILE No.")
        {
        }
    }
}