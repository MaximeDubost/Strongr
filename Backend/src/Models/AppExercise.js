class AppExercise {
    constructor(id, name, muscleList, equipmentList) {
        this.id_app_exercise = id
        this.name_app_exercise = name
        this.muscleList = muscleList
        this.equipmentList = equipmentList
    }

    static class(obj) {
        //console.log(obj)
        return new AppExercise(obj.id, obj.name, obj.muscleList, obj.equipmentList);
    }

}

export default AppExercise