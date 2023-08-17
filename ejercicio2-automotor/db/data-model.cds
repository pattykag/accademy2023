namespace automotive;

entity Countries {
    key ID          : String(2);
        countryName : String(255);
}

aspect InitialData {
    key ID          : String(3);
    @mandatory name : String(100);
}

entity Brands : InitialData {
    @mandatory country : Association to Countries;
    comment            : String(255);
    model              : Composition of many Models
                             on model.brand = $self;
}

entity Models : InitialData {
    brand   : Association to Brands;
    comment : String(255);
    version : Composition of many Versions
                  on version.model = $self;
}

entity Versions {
    key model   : Association to Models;
    key color   : String(255);
        price   : Decimal(13, 2);
        comment : String(255);
}
