pageextension 50067 "Journal Voucher Ext." extends "Journal Voucher"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            var
            begin
                if not confirm('Please Check Employee Posting Group. \n Do you want to continue posting then press yes else press No') then
                    exit;
            end;
        }
        modify(PostAndPrint)
        {
            trigger OnBeforeAction()
            var
            begin
                if not confirm('Please Check Employee Posting Group. \n Do you want to continue posting then press yes else press No') then
                    exit;
            end;
        }
    }

    var
        myInt: Integer;
}