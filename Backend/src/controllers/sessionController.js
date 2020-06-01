import SessionRepository from "../repository/SessionRepository"
const controller = {};

controller.getSessions = async (req, res) => {
    try {
        var session = await sessionRepository.getSessions(req)
        res.status(200).json(session)
    } catch (error) {
        console.log(error)
    }
}

controller.getSessionDetail = async (req, res) => {
    try {
        var sessions = await sessionRepository.getSessionDetail(req)
        if (sessions === 404) {
            res.sendStatus(session)
        } else {
            res.status(200).json(sessions)
        }
    } catch (error) {
        console.log(error)
    }
}

controller.addSession = async (req, res) => {
    try {
        var result = await SessionRepository.addSession(req)
        if (result == 501) {
            res.sendStatus(501)
        } else {
            res.sendStatus(200)
        }
    } catch (error) {
        console.log(error)
    }
}

controller.deleteSession = async (req, res) => {
    try {
        var result = await SessionRepository.deleteSession(req)
        if (result == 501) {
            res.sendStatus(501)
        } else {
            res.sendStatus(200)
        }
    } catch (error) {
        console.log(error)
    }
}

controller.updateSession = async (req, res) => {
    try {
        var result = await SessionRepository.updateSession(req)
        if (result == 501) {
            res.sendStatus(501)
        } else {
            res.sendStatus(200)
        }
    } catch (error) {
        console.log(error)
    }
}

export default controller