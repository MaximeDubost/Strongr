class Set {
    constructor(id_set, app_exercise, user, exercise, repetitions_count, rest_time, expected_performance, realized_performance) {
        this.id_set = id_set
        this.app_exercise = app_exercise
        this.user = user
        this.exercise = exercise
        this.repetitions_count = repetitions_count
        this.rest_time = rest_time
        this.expected_performance = expected_performance
        this.realized_performance = realized_performance
    }
}

export default Set