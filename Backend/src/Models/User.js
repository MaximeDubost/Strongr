class User {
    constructor(id_user, email, password, firstname, lastname, phonenumber, birthdate, username, signeddate, recoverycode) {
        this.id_user = id_user
        this.email = email
        this.password = password
        this.firstname = firstname
        this.lastname = lastname
        this.phonenumber = phonenumber
        this.birthdate = birthdate
        this.username = username
        this.signeddate = signeddate
        this.recoverycode = recoverycode
    }
}

export default User