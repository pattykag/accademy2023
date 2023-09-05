const cds = require('@sap/cds');

module.exports = cds.service.impl(async (srv) => {
    srv.before('CREATE', 'Recordings', async (req) => {
        const {hourQuantity} = req.data;
        console.log('hourQuantity', hourQuantity);
         
        if (hourQuantity >= 6) {
            req.data.promo = true;
            req.data.hourQuantity = hourQuantity + 2;
        }
    })
});