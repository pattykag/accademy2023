using {
    cuid,
    managed
} from '@sap/cds/common';

namespace label;

entity Bands : cuid {
    name     : longname;
    founded  : Date;
    musician : Association to many Bands_Musiciands
                   on musician.band = $self;
}

entity Musicians : cuid {
    name      : shortname;
    lastname  : shortname;
    birthday  : Date;
    band      : Association to many Bands_Musiciands
                    on band.musician = $self;
    recording : Composition of many Recordings
                    on recording.musician = $self;
}

entity Bands_Musiciands : cuid {
    band     : Association to Bands;
    musician : Association to Musicians;
}

entity Disks : cuid {
    name         : longname;
    tracks       : Integer;
    band         : Association to Bands;
    distribution : Association to many Disks_Distributions
                       on distribution.disk = $self;
}

entity Distributions : cuid {
    name : longname;
    disk : Association to many Disks_Distributions
               on disk.distribution = $self;
}

entity Disks_Distributions : cuid {
    distribution : Association to Distributions;
    disk         : Association to Disks;
}

entity Recordings : cuid, managed {
    hourQuantity  : Integer;
    recordingDate : Date;
    musician      : Association to Musicians;
    disk          : Association to Disks;
}

type longname  : String(99);
type shortname : String(55);
