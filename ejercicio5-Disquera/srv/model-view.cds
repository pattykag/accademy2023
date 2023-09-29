using {label as my} from '../db/data-model';

service labelservice {
    @cds.redirection.target
    entity Musicians             as projection on my.Musicians;
    entity Bands                 as projection on my.Bands;
    entity Bands_Musicians       as projection on my.Bands_Musicians;
    entity Disks                 as projection on my.Disks;
    entity Disks_Distributions   as projection on my.Disks_Distributions;

    @cds.redirection.target
    entity Distributions         as projection on my.Distributions;

    @cds.redirection.target
    entity Recordings            as projection on my.Recordings;

    entity MusicianBand as select from my.Musicians {
        band.musician.name as musician_name,
        band.band.name as band_name,
        recording.disk.name as disk_name,
        recording.disk.tracks as tracks,
        recording.disk.distribution.distribution.name as distributed_name
    };

    // 1
    entity BandDistribution      as
        select from my.Distributions {
            name                as distributedBy,
            disk.disk.band.name as bandName,
            disk.disk.name      as diskName,
            disk.disk.tracks
        };

    // 2
    entity MusicianRecordingDate as
        select from my.Recordings {
            *,
            musician.name     as musicianName,
            musician.lastname as musicianLastname,
            disk.name         as diskName,
            disk.band.name    as bandName,
            disk.band.genre
        }
        excluding {
            createdAt,
            createdBy,
            modifiedAt,
            modifiedBy
        }
        where
            promo = true
        order by
            recordingDate desc
        limit 1;

    action   deleteMusicians(value : array of UUID);
    action   createMusicians(value : array of Musicians) returns oMessage;
    function musicianID(ID : UUID)                       returns Musicians;
}

type oMessage {
    code    : Integer;
    message : String(255);
}
