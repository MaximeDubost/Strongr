import clt from "../core/config/database";

const repository = {};
repository.getEquipmentByID = async (req) => {
    let sql = `
    SELECT id_equipment as id, name, description, image
    FROM _equipment 
    WHERE id_equipment = $1    
    `;
    try {
        let result = await clt.query(sql, [req.params.id_equipment]);
        return result.rows;
    } catch (error) {
        console.log(error);
        return 500;
    }
}
export default repository;