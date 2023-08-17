using {sales as my} from '../db/data-models';

@(impl: './custom-logic.js')
service storeSales {
    entity Clients    as projection on my.Clients;
    entity Products   as projection on my.Products;
    entity Categories as projection on my.Categories;
    action categoryMassUpload(value : array of Categories) returns oMessage;
}

type oMessage {
    code    : Integer;
    message : String(255);
}
