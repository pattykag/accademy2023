using { label as my } from '../db/data-model';

service labelservice {
    entity Musicians as projection on my.Musicians;
}