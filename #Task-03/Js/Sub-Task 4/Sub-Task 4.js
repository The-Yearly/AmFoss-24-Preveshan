const fs=require("fs");
 function write(n){
    if ((n%2)==1){
        x=Math.floor(n/2);
        var c=n-x-1;
        var m=1;
        var s1=-1;
        var s2=1;
        var spa;
        var s;
        for(var g=0;g<n;g++){
            if (c!=0){
                spa=(" ".repeat(c));
            }
            else{
                spa="";
            }
            s=spa+"*".repeat(m)+"\n";
            fs.appendFile("output.txt",s,err=>{
                if(err){
                    console.err;
                    return;
                }
            })
            m+=(s2*2)
            c+=s1
            if (c==0){
                s1=1}
            if (m>n){
                s2=-1
                m=n-2}
        }

    }else{
        console.log("Pls Enter A Even Number");
    }       
}
fs.readFile("input.txt","utf-8",(err,data)=>{
    fs.writeFile("output.txt","",err=>{
        if(err){
            console.err;
            return;
        }
    })
    write(data);
    console.log("Finished")
});