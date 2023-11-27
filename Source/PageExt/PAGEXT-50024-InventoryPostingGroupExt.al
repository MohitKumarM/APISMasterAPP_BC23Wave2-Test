pageextension 50024 "Inventory Posting Group Ext." extends "Inventory Posting Groups"
{
    layout
    {
        addlast(Control1)
        {
            field("Planning Applicable"; Rec."Planning Applicable")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}