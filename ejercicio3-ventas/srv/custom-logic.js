const cds = require('@sap/cds');

module.exports = cds.service.impl(async (srv) => {
    const { Categories } = srv.entities;

    srv.on('categoryMassUpload', async req => {
        console.log('Datos', req.data.value);

        try {
            const oData = req.data.value;

            let iInsert = 0;
            for (let i = 0; i < oData.length; i++) {
                iInsert += await INSERT.into(Categories).entries(oData[i]);
            }
            console.log(`Número de filas insertas ${iInsert}`);

            const oMessage = {
                code: 200,
                message: `Número de filas insertas ${iInsert}`
            }
            return oMessage;
        } catch (error) {
            req.reject(400, error);
        }
    });
});