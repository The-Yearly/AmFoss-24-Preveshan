document.addEventListener("DOMContentLoaded",(event)=>{
    let m=JSON.parse(localStorage.getItem("cart"));
    let billing=document.querySelector(".billingarea");
    let total_price=localStorage.getItem("cost");
    console.log(m[1][2]);
    for(g in m){
        let label = document.createElement("div");
        label.classList.add("label");
        billing.appendChild(label);
        let image=document.createElement("img");
        image.classList.add("billimg");
        image.src=m[g][2];
        let title=document.createElement("p");
        title.classList.add("title");
        label.appendChild(image);
        label.appendChild(title)
        title.innerHTML = m[g][0];
        let priceitem=document.createElement("p");
        priceitem.classList.add('priceitem');
        priceitem.innerHTML="$"+m[g][1];
        label.appendChild(priceitem);
        let br=document.createElement("br");
        billing.appendChild(br);
    }
    let bill=document.createElement("div");
    bill.classList.add("bill");
    billing.appendChild(bill);
    let pt=document.createElement("p");
    pt.innerHTML="Shipping:         Free";
    pt.setAttribute("id","Shipping")
    bill.appendChild(pt);
    let cost=document.createElement("p");
    cost.setAttribute("id","totalcost");
    cost.innerHTML="Total Cost:"+"  $"+total_price;
    bill.appendChild(cost);
    let purchase_button=document.createElement("button");
    purchase_button.innerHTML="Confirm Purchase";
    purchase_button.setAttribute("id","purchase_button")
    let newline=document.createElement("br")
    bill.appendChild(purchase_button);
    bill.appendChild(newline);
});