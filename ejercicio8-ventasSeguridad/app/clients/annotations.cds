using storeSales as service from '../../srv/service';

annotate service.Clients with {
    name     @title: '{i18n>name}';
    lastname @title: '{i18n>lastname}';
    dni      @title: '{i18n>dni}';
    birthday @title: '{i18n>birthday}';
    country  @title: '{i18n>country}';

    // Valuehelp - Country
    country  @(Common: {
        ValueListWithFixedValues,
        ValueList: {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Countries',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: country_code,
                    ValueListProperty: 'code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name',
                }
            ]
        },
    });
};

annotate service.Clients with @UI: {
    // table title
    HeaderInfo      : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : '{i18n>singular}',
        TypeNamePlural: '{i18n>plural}',
    },
    // fields to be shown on the table
    LineItem        : [
        {Value: name},
        {Value: lastname},
        {Value: dni},
        {Value: birthday},
        {Value: country.name}
    ],
    // object page window => pointing to #Main
    Facets          : [{
        $Type : 'UI.ReferenceFacet',
        Label : '{i18n>facetsTitle}',
        Target: '@UI.FieldGroup#Main'
    }],
    // #Main - fields to be filled
    FieldGroup #Main: {Data: [
        {Value: name},
        {Value: lastname},
        {Value: dni},
        {Value: birthday},
        {Value: country_code}
    ]}
};
