using {automotive as my} from '../db/data-model';

@(path: '/autoservice')
service MyService {
    entity Brands    as select from my.Brands;
    entity Models    as select from my.Models;

    @cds.redirection.target
    entity Versions  as select from my.Versions;

    @readonly
    entity Countries as select from my.Countries;

    entity Cars      as
        select from my.Versions {
            *,
            model.name                      as model_Name,
            model.brand.ID                  as brand_ID,
            model.brand.name                as brand_Name,
            model.brand.country.ID          as country_ID,
            model.brand.country.countryName as country_Name
        }
        excluding {
            comment
        };

// action batchMarcas(value : array of Marcas) returns oMessage;
}

// type oMessage {
//     code    : Integer;
//     message : String(255);
// }
