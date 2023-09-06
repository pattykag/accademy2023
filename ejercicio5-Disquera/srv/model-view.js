const cds = require('@sap/cds');

module.exports = cds.service.impl(async (srv) => {
    const { Musicians, Bands_Musicians, Recordings } = srv.entities;

    srv.before('CREATE', 'Recordings', async (req) => {
        const { hourQuantity } = req.data;

        try {
            console.log('hourQuantity', hourQuantity);

            if (hourQuantity >= 6) {
                req.data.promo = true;
                req.data.hourQuantity = hourQuantity + 2;
            }
        } catch (error) {
            req.reject(400, error);
        }
    });

    srv.on('deleteMusicians', async (req) => {
        console.log(req.data.value);
        const ID = req.data.value;

        try {
            const musicians = await SELECT.from(Musicians).columns('name', 'lastname').where({ ID });
            console.log('musicians', musicians);

            // await DELETE.from(Musicians).where({ ID }); => Igual que la de abajo
            await DELETE.from(Musicians, { ID });
            await DELETE.from(Recordings, { musician_ID: ID }); // es una composition a 'Musicians'
            await DELETE.from(Bands_Musicians, { musician_ID: ID }); // borrar porque está relacionado con 'Recordings'

            musicians.forEach(element => {
                console.log(`Músico eliminado: ${element.name} ${element.lastname}`);
            });
        } catch (error) {
            req.reject(400, error);
        }
    });

    srv.on('createMusicians', async (req) => {
        const value = req.data.value;
        console.log(value);

        try {
            await INSERT(value).into(Musicians);

            const oMessage = {
                code: 200,
                message: `Número de filas insertas ${value.length}`
            }
            return oMessage;
        } catch (error) {
            req.reject(400, error);
        }
    });
});