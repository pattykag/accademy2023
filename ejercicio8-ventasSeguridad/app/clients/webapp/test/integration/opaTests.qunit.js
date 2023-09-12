sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/clients/test/integration/FirstJourney',
		'ns/clients/test/integration/pages/ClientsList',
		'ns/clients/test/integration/pages/ClientsObjectPage'
    ],
    function(JourneyRunner, opaJourney, ClientsList, ClientsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/clients') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheClientsList: ClientsList,
					onTheClientsObjectPage: ClientsObjectPage
                }
            },
            opaJourney.run
        );
    }
);