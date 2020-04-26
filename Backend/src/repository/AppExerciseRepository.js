import Muscle from "../Models/Muscle"
import AppExercise from "../Models/AppExercise"
import Equipment from "../Models/Equipment"
import clt from "../core/config/database";



const repository = {};

repository.getAllAppExercises = async () => {
    var appExList = []
    let sqlGetAllAppExercises = `
    SELECT ae.id_app_exercise, ae.name as exercise_name, mu.id_muscle, mu.name as muscle_name
    FROM _app_exercise ae
    JOIN _app_exercise_muscle ta ON ae.id_app_exercise = ta.id_app_exercise
    JOIN _muscle mu ON ta.id_muscle = mu.id_muscle
    ORDER BY id_app_exercise
    `
    try {
        var result = await clt.query(sqlGetAllAppExercises);
        // console.log(result.rows)
        var exists = false
        var j = 0
        var k = -1
        // console.log()
        // console.log("ID du dernier élément : " + result.rows[result.rows.length - 1].id_app_exercise)
        // console.log()
        for (var i = 1; i <= result.rows[result.rows.length - 1].id_app_exercise; i++) {
            // console.log("(i) Tour de boucle : " + i)
            result.rows.map((row) => {
                if (i === row.id_app_exercise) {
                    if (!exists) {
                        appExList.push(new AppExercise(row.id_app_exercise, row.exercise_name, [], []))
                        exists = true
                        k++
                    }
                    // console.log("Avant push muscle ", appExList[k])
                    AppExercise.class(appExList[k]).muscleList.push(new Muscle(row.id_muscle, row.muscle_name))
                    // console.log("Après push muscle ", appExList[k])
                    j++
                    // console.log("(j) Nb Muscle(s) ajouté(s) à cet AE : " + j)
                    // console.log("(k) Indice dans appExList : " + k)
                }
            })
            exists = false
            j = 0
            // console.log()
        }
        // console.log(appExList)
        return appExList;
    }
    catch (error) {
        console.error(error)
    }
}

repository.getDetailAppExercise = async (body) => {
    var appExList = []
    let getDetailAppExercise = `
    SELECT ae.id_app_exercise, ae.name as exercise_name, mu.id_muscle, mu.name as muscle_name, eq.name as equipment_name, eq.id_equipment as id_equipment
    FROM _app_exercise ae JOIN _app_exercise_muscle ta ON ae.id_app_exercise = ta.id_app_exercise
    JOIN _muscle mu ON ta.id_muscle = mu.id_muscle
    JOIN _app_exercise_equipment aeeq ON ae.id_app_exercise = aeeq.id_app_exercise 
    JOIN _equipment eq ON eq.id_equipment = aeeq.id_equipment
    WHERE ae.id_app_exercise = $1
    `
    try {
        var result = await clt.query(getDetailAppExercise, [body.id_app_exercise]);
        // console.log(result.rows)
        var exists = false
        var j = 0
        var k = -1
        for (var i = 1; i <= result.rows[result.rows.length - 1].id_app_exercise; i++) {
            result.rows.map((row) => {
                if (i === row.id_app_exercise) {
                    if (!exists) {
                        appExList.push(new AppExercise(row.id_app_exercise, row.exercise_name, [], []))
                        exists = true
                        k++
                    }
                    // console.log("Avant push muscle ", appExList[j])
                    var muscleExist = AppExercise.class(appExList[k]).muscleList.filter(muscle => muscle.id === row.id_muscle)
                    // console.log(muscleExist.length)
                    if (muscleExist.length === 0) {
                        AppExercise.class(appExList[k]).muscleList.push(new Muscle(row.id_muscle, row.muscle_name))
                    }
                    var equipmentExist = AppExercise.class(appExList[k]).equipmentList.filter(equipment => equipment.id === row.id_equipment)
                    // console.log(equipmentExist.length)
                    if (equipmentExist.length === 0) {
                        AppExercise.class(appExList[k]).equipmentList.push(new Equipment(row.id_equipment, row.equipment_name))
                    }
                    // console.log("Après push muscle ", appExList[j])
                    j++
                }
            })
            exists = false
            j = 0
        }
        return appExList;
    }
    catch (error) {
        console.error(error)
    }
}

export default repository;