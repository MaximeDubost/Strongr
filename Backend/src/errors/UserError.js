class UserError extends Error {
    constructor(statusCode, message) {
        super(message)
        this.status = statusCode
    }
}

export default UserError