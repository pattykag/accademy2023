namespace storesmanagement;

using {
    cuid,
    managed
} from '@sap/cds/common';


entity Owners : cuid, managed {
    name     : String(30);
    lastname : String(30);
    dni      : String(8);
    store    : Association to many Owners_Stores
                   on store.owner = $self;
}

entity Stores : cuid, managed {
    name    : String(99);
    started : Date;
    product : Association to many Products_Stores
                  on product.store = $self;
    owner   : Association to many Owners_Stores
                  on owner.store = $self;
}

entity Owners_Stores : cuid {
    owner : Association to Owners;
    store : Association to Stores;
}

entity Products : cuid {
    name     : String(55);
    category : String(55);
    price    : Decimal(8, 2);
    store    : Association to many Products_Stores
                   on store.product = $self;
}

entity Products_Stores : cuid {
    product : Association to Products;
    store   : Association to Stores;
}
