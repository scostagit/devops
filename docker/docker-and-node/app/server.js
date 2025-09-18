const express = require('express');
const app = express();


app.get('/', (req, res) => {
    res.json({application: "NodeJs Bolierplate", version:"1.0"});
});

app.listen(8080, ()=> console.log('Aplicação rodando na porta 8080'));

