class AppExercise {
    constructor(id, name, muscleList) {
        this.id = id
        this.name = name
        this.muscleList = muscleList
    }

    static class(obj) {
        console.log(obj)
        return new AppExercise(obj.id, obj.name, obj.muscleList);
    }

}

export default AppExercise