const express = require('express');
const router = express.Router();

router.get('/', (req, res, next) => {
    res.status(200).json({
        mesage: 'Machine were fetched'
    });
});

router.post('/', (req, res, next) => {
    res.status(201).json({
        mesage: 'Machine was created'
    });
});

router.get('/:id', (req, res, next) => {
    const id = req.params.id;
    res.status(200).json({
        mesage: 'Détails de la machine',
        id: id
    });
});

router.delete('/:id', (req, res, next) => {
    const id = req.params.id;
    res.status(200).json({
        mesage: 'Machine supprimée',
        id: id
    });
});


module.exports = router;