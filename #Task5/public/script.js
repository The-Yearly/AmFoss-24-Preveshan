const terminalOutput = document.querySelector('.terminal-output');
const terminalInput = document.querySelector('input[type="text"]');
terminalInput.addEventListener("keypress",function(event){
    if (event.key=="Enter"){
        handleInput(terminalInput.value);
    }
})
let cart={};
let itemdic={"i1":["d1","p1"],"i2":["d2","p2"],"i3":["d3","p3"],"i4":["d4","p4"],"i5":["d5","p5"],"i6":["d6","p6"],"i7":["d7","p7"],"i9":["d9","p9"],"i10":["d10","p10"],"i11":["d11","p11"],"i12":["d12","p12"],"i13":["d13","p13"],"i8":["d8","p8"],"i14":["d14","p14"],"i15":["d15","p15"],"i16":["d16","p16"],"i17":["d17","p17"],"i18":["d18","p18"],"i19":["d19","p19"],"i20":["d20","p20"]};
let items;
let bill={"0":["Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",109.95,"https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"],"2":["Mens Casual Premium Slim Fit T-Shirts ",22.3,"https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg"]};
let total=parseFloat(0.00);
function handleInput(command) {
    switch (true){   
        case command=='help':
            viewCommand();
            break;
        case command=="sort name":
            fetch('https://fakestoreapi.com/products?sort').then(res=>res.json()).then(val=>sortname(val));
            break
        case command=="list":
            for(let g=0;g<items.length;g++){
                terminalOutput.innerHTML+=g+1+")"+items[g].title+"\n";
            }
            break;
        case command=="sort price":
            fetch('https://fakestoreapi.com/products?').then(res=>res.json()).then(val=>sortitems(val));
            break;
        case command=="cart":
            for(g in cart){
                terminalOutput.innerHTML+=g+": "+cart[g][0]+" $"+cart[g][1]+"\n";
            }
            break;
        case command.includes("search"):
            searchitem(command);
            break;
        case command=="buy":
            buy_products();
            break;
        case command.includes("details"):
            getdetails(command);
            break;
        case command=="clear":
            terminalOutput.innerHTML="";    
            break;
        case command.includes("add"):
            additems(items,command);
            break;
        case command.includes("remove"):
            removeitem(command);
            break;
        default:
            terminalOutput.textContent += `Invalid command: ${command}\n`;
            break;
    }

    terminalInput.value = '';
}
function buy_products(){
    localStorage.setItem("cart",JSON.stringify(cart));
    localStorage.setItem("cost",total);
    window.location.replace("bill.html");
}
function getdetails(command){
    let t=command.split(" ");
    let searchid=t[1];
    try{
        for(j in items){
            let pid=items[j].id;
            if(pid==searchid){
                terminalOutput.innerHTML+="name: "+items[j].title+"\n"+"Description: "+items[j].description+"\n"+"Price: "+items[j].price+"\n";
            }
        }
    }
    catch{
        terminalOutput.innerHTML+="Sorry Could Find The Item "+"\n";
    }
}
function searchitem(command){
    let t=command.split(" ");
    let searchterm="";
    try{
        for(let g=1;g<t.length;g++){
            searchterm+=t[g]+" ";
        }
        searchterm=searchterm.toLowerCase();
        searchterm=searchterm.trim();
        for(j in items){
            let pname=items[j].title;
            pname=pname.toLowerCase();
            if(pname.includes(searchterm)){
                terminalOutput.innerHTML+=pname+"\n";
            }
        }
    }
    catch{
        terminalOutput.innerHTML+="Sorry Could Find The Item "+"\n";
    }
}
function additems(items,command){
    let t=command.split(" ");
    let p=Object.keys(cart).length;
    try{
        let name=items[t[1]-1].title;
        let price=items[t[1]-1].price;
        let img=items[t[1]-1].image;
        total+=price;
        document.getElementById("price").innerHTML=total;
        terminalOutput.innerHTML+="Added "+name+"\n";
        cart[p+1]=[name,price,img];
        console.log(cart);
    }
    catch{
        terminalOutput.innerHTML+="Sorry Product Not Found Pls Enter A Valid ID\n";
    }
}
function removeitem(command){
    let t=command.split(" ");
    try{
        let price=parseFloat(cart[t[1]][1]);
        total=parseFloat(total)-price;
        terminalOutput.innerHTML+="Removed "+cart[t[1]]+"\n"
        delete cart[t[1]];
        document.getElementById("price").innerHTML=total;
    }
    catch{
        terminalOutput.innerHTML+="Sorry Product Not Found Pls Id\n";
    }

}
function sortname(val){
    val.sort((a, b) => a.title.localeCompare(b.title));
    items=val;
    terminalOutput.innerHTML+="Sorted By Name\n"
    setitems(val);
}
function viewCommand() {
    terminalOutput.innerHTML += "Available Commands:\nlist: to see products\nsort name: Sort By Name\nsort price: Sort By price\add [product_id]: Add Product To Cart\nremove [product_id]\ncart: To view Cart\nsearch [product_name]:To search product by name\ndetails [product_id]: To get details of product\nclear: Clear Terminal\nbuy: Buy Items In Cart\nhelp: To view Commands\n"
    
}
function sortitems(val){
    val.sort((a, b) => a.price - b.price);
    terminalOutput.innerHTML+="Sorted By Price\n"
    setitems(val);
}
let img_holders=["i1","i2","i3","i4","i5","i6","i7","i8","i9","i10","i11","i12","i13","i14","i15","i16","i17","i18","i19","i20"];
function setitems(val){
    items=val;
    console.log(val)
    for(g=0;g<img_holders.length;g++){
        document.getElementById(img_holders[g]).src=val[g].image;
        document.getElementById(itemdic[img_holders[g]][0]).innerHTML=val[g].title;
        document.getElementById(itemdic[img_holders[g]][1]).innerHTML="$"+val[g].price;
    }
}
addEventListener("DOMContentLoaded", (event) => {
    document.getElementById("price").innerHTML=total;
    fetch('https://fakestoreapi.com/products').then(res=>res.json()).then(val=>setitems(val));
});
function showdesc(f){
    let d=document.getElementById(itemdic[f.id][0])
    d.style.transform="translateY(55px)";
}
function hidedesc(f){
    let d=document.getElementById(itemdic[f.id][0])
    d.style.transform="translateY(-55px)";
}