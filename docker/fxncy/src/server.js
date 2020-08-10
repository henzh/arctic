'use strict';

const express = require('express');

const HOST = '0.0.0.0';
const PORT = 5000;

const app = express();

app.get('/ping', (req, res) => {
  res.send('Fxncy is healthy!');
});

app.listen(PORT, HOST);
