let express=require("express");
let path=require("path");
const app=express();
app.use(express.text());
app.use(express.json());
app.use(express.static('public'));
app.get("/",(req,res) =>{
    res.sendFile(path.join(__dirname,"public",'index.html'));
});
app.listen(8080,() =>{
    console.log("Server Starting Hi ;)");
});
