    const fs=require("fs");
    fs.readFile("input.txt","utf-8",(err,data)=>{
        fs.writeFile("output.txt",data,err=>{
            if(err){
                console.log(err);
                return;
            }
        });
    });