const cds = require('@sap/cds');

module.exports = cds.service.impl(async (srv) => {
    const { Musicians } = srv.entities;

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
            // las horas de grabación vinculadas al músico también son eliminadas debido a la composition (Recordings)

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

    srv.on('musicianID', async (req) => {
        const { ID } = req.data;
        console.log(ID);

        try {
            const query = await SELECT.from(Musicians, { ID });
            return query;
        } catch (error) {
            req.reject(400, error);
        }
    });
});