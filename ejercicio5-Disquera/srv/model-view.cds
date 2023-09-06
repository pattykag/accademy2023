using {label as my} from '../db/data-model';

service labelservice {
    entity Musicians           as projection on my.Musicians;
    entity Bands               as projection on my.Bands;
    entity Bands_Musicians     as projection on my.Bands_Musicians;
    entity Disks               as projection on my.Disks;
    entity Distributions       as projection on my.Distributions;
    entity Disks_Distributions as projection on my.Disks_Distributions;
    entity Recordings          as projection on my.Recordings;

    action deleteMusicians (value: array of UUID);
    action createMusicians (value : array of Musicians) returns oMessage;
}

type oMessage {
    code    : Integer;
    message : String(255);
}