using {sales as my} from '../db/data-models';

service storeSales {
    entity Clients  as projection on my.Clients;
    entity Products as projection on my.Products;
}
