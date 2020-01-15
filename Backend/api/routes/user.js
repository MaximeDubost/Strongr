const express = require('express');
const router = express.Router();

router.get('/', (req, res, next) => {
    res.status(200).json({
        mesage: 'Handling GET request to /user'
    });
});

router.post('/', (req, res, next) => {
    res.status(201).json({
        mesage: 'Handling POST request to /user'
    });
});

router.get('/:id', (req, res, next) => {
    const id = req.params.id;
    res.status(200).json({
        mesage: 'You passed an ID',
        id: id
    });
});

router.patch('/:id', (req, res, next) => {
    res.status(200).json({
        mesage: 'Updated product !',
    });
});

router.delete('/:id', (req, res, next) => {
    res.status(200).json({
        mesage: 'Deleted product !',
    });
});

module.exports = router;