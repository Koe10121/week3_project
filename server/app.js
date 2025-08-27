const express = require('express');
const app = express();
const bcrypt = require('bcrypt'); 
const con = require('./db');

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
