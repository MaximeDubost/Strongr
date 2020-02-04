import express from 'express';

import userController from '../controllers/userController';

let router = express.Router();

/** CRUD + LOGIN user */
router.post('/user/add', userController.addUser);
router.put('/user/update', userController.updateUser);
router.delete('/user/delete', userController.deleteUser);
router.post('/login', userController.login);



export default router;
