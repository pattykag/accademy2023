using {storesmanagement as my} from '../db/schema';

service stores {
    entity Products        as
        select from my.Products {
            *
        }
        excluding {
            createdAt,
            createdBy,
            modifiedAt,
            modifiedBy
        };

    entity Owners          as
        select from my.Owners {
            *
        }
        excluding {
            createdAt,
            createdBy,
            modifiedAt,
            modifiedBy
        };

    @cds.redirection.target
    entity Stores          as
        select from my.Stores {
            *
        }
        excluding {
            createdAt,
            createdBy,
            modifiedAt,
            modifiedBy
        };

    entity Products_Stores as projection on my.Products_Stores;
    entity Owners_Stores   as projection on my.Owners_Stores;

    // enunciado
    entity Store_View as select from my.Stores {
        *,
        product.product.name as productName,
        product.product.price,
        owner.owner.name as ownerName,
        owner.owner.lastname as ownerLastname
    }
}
