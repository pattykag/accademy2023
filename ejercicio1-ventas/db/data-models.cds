using {
    cuid,
    managed
} from '@sap/cds/common';

namespace sales;

entity Clients : cuid, managed {
    @mandatory name     : String(30);
    @mandatory lastname : String(30);
    @mandatory dni      : String(10);
    birthday            : Date;
}

entity Products : cuid, managed {
    @mandatory productName              : String(50);
    @mandatory precio                   : Double;
    @mandatory stock                    : Integer;
    @mandatory minimumStock             : Integer;
    @assert.range  @mandatory  category : String(30) enum { // sólo permite guardar 'LP', 'FB'
        Limpieza   = 'LP';
        Fiambreria = 'FB'
    };
    description: String(50);
}
