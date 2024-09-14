use std::io;
fn main(){
    println!("Enter n: ");
    let mut input=String::new();
    io::stdin().read_line(&mut input).expect("Failed to read input");
    let n: i32=input.trim().parse().expect("Didnt get number");
    if n%2!=0{
        let mut c=n-(n/2)-1;
        let mut m=1;
        let mut s1=-1;
        let mut s2=1;
        for g in 0..n {
            if c!=0{
                print!("{}"," ".repeat(c as usize));
            }
            println!("{}","*".repeat(m as usize));
            m+=s2*2;
            c+=s1;
            if c==0{
                s1=1;
            }if m>n{
                s2=-1;
                m=n-2;
            }
        }
    } else {
        println!("Enter An Odd Number");
    }
}
