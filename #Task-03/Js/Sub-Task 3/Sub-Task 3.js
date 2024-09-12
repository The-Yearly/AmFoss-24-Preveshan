var n=process.argv.slice(2);
if ((n%2)==1){
    x=Math.floor(n/2);
    var c=n-x-1;
    var m=1;
    var s1=-1;
    var s2=1;
    for(var g=0;g<n;g++){
        if (c!=0){
            process.stdout.write(" ".repeat(c));
        }
        console.log("*".repeat(m))
        m+=(s2*2)
        c+=(s1*1)
        if (c==0){
            s1=1}
        if (m>n){
            s2=-1
            m=n-2}
    }

}else{
    console.log("Pls Enter A Even Number");
}