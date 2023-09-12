using {sales as my} from '../db/data-models';

@impl     : './custom-logic.js'
@_requires: 'authenticated-user'
service storeSales {
    @odata.draft.enabled //habilita el draft y el botón de crear-editar en fiori elements
    entity Clients    as projection on my.Clients;
    entity Products   as projection on my.Products;
    entity Categories as projection on my.Categories;
}
