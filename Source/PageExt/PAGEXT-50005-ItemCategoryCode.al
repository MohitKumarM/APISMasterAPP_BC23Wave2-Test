pageextension 50005 ItemCategoryCode extends "Item Categories"
{
    layout
    {
        addafter(Description)
        {
            field("GAN Tolerance %"; Rec."GAN Tolerance %")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}