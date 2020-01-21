const controller = {};

controller.addUser = async (req, res) => {
    let body = {};
    let status = 200;

    try {

    } catch (err) {
        status = 500;
        console.log(err.message);
        body = { message: 'Une erreur est survenue...' };
    }
    res.status(status).json(body);
}
controller.updateUser = async (req, res) => {
    let body = {};
    let status = 200;

    try {

    } catch (err) {
        status = 500;
        console.log(err.message);
        body = { message: 'Une erreur est survenue...' };
    }
    res.status(status).json(body);
}
controller.deleteUser = async (req, res) => {
    let body = {};
    let status = 200;

    try {

    } catch (err) {
        status = 500;
        console.log(err.message);
        body = { message: 'Une erreur est survenue...' };
    }
    res.status(status).json(body);
}
controller.login = async (req, res) => {
    let body = {};
    let status = 200;

    try {

    } catch (err) {
        status = 500;
        console.log(err.message);
        body = { message: 'Une erreur est survenue...' };
    }
    res.status(status).json(body);
}
export default controller;