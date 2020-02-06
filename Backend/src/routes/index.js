import express from 'express';

import userController from '../controllers/userController';
//import exerciseController from '../controllers/exerciseController';

let router = express.Router();

/** CRUD + LOGIN user */
router.post('/user/add', userController.addUser);
router.get('/user/:id_user', userController.getUser)
router.put('/user/update/:id_user', userController.updateUser);
router.delete('/user/delete/:id_user', userController.deleteUser);
router.post('/login', userController.login);

//router.get()



export default router;

