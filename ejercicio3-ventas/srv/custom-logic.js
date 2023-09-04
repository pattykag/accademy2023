const cds = require('@sap/cds');

module.exports = cds.service.impl(async (srv) => {
    const { Products } = srv.entities;

    srv.before('UPDATE', 'Products', async (req) => {
        const { ID, stock } = req.data;
        console.log('ID', ID);
        console.log('stock', stock);

        //const query = await SELECT.one.from(Products).columns('minimumStock').where({ ID }); => Esta consulta es igual que la de abajo
        const query = await SELECT.one.from(Products, ID).columns('minimumStock', 'productName');
        const { minimumStock, productName } = query;
        console.log('minimumStock', minimumStock);

        if (minimumStock > stock) {
            console.log(`Debe reponer ${productName}, ya que el mínimo es ${minimumStock} y ud. tiene ${stock}`);
            req.warn(100, `Debe reponer ${productName}, ya que el mínimo es ${minimumStock} y ud. tiene ${stock}`)
        } else {
            console.log('El producto fue actualizado correctamente');
        }
    });
});