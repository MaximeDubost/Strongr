import clt from "../core/config/database";

const repository = {};
repository.getEquipementByIDAppExercice = async (req) => {
    let sql = `
    SELECT e.id_equipment as id, e.name as name 
    FROM _app_exercise_equipment as aee 
    JOIN _equipment as e ON aee.id_equipment = e.id_equipment
    WHERE aee.id_app_exercise = $1    
    `;
    try {
        let result = await clt.query(sql, [req.params.id_app_exercise]);
        return result.rows;
    } catch (error) {
        console.log(error);
        return 500;
    }
}
export default repository;