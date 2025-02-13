

const express = require('express');
const mongoose = require('mongoose');

const app = express();
const port = process.env.port || 3000;

mongoose.connect("mongodb+srv://onlychef:566446644@cluster0.r1gi3.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0y").then(() => console.log('Connected to MongoDB')).catch(err => console.log(er));
app.use(express.json());


app.listen(port, "0.0.0.0", () => console.log(`Server listening on ports ${port}!`));
