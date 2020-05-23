class AppExercise {
    constructor(id, name, muscleList, equipmentList) {
        this.id = id
        this.name = name
        if (muscleList != null && equipmentList != null) {
            this.muscleList = muscleList
            this.equipmentList = equipmentList
        }
    }

    static class(obj) {
        console.log(obj)
        return new AppExercise(obj.id, obj.name, obj.muscleList, obj.equipmentList);
    }

}

export default AppExercise