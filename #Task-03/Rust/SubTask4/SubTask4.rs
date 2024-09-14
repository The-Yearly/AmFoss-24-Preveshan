use std::fs::File;
use std::io::{self, Write, Read};
fn read() -> io::Result<String> {
    let mut file = File::open("input.txt")?;
    let mut contents = String::new();
    file.read_to_string(&mut contents)?;
    Ok(contents)
}
fn write(content: &str) -> io::Result<()> {
    let mut file = File::create("output.txt")?;
    file.write_all(content.as_bytes())?;
    Ok(())
}
fn main(){
    let contents = match read() {
        Ok(contents) => contents,
        Err(e) => {
            eprintln!("ErrorReading {}", e);
            return
        },
    };
    let n: i32=contents.parse().unwrap();
    if n%2!=0{
        let mut c=n-(n/2)-1;
        let mut m=1;
        let mut s = String::new();
        let mut s1=-1;
        let mut s2=1;
        for g in 0..n {
            if c!=0{
                s.push_str(&" ".repeat(c as usize));
            }
            s.push_str(&"*".repeat(m as usize));
            s.push_str("\n");
            m+=s2*2;
            c+=s1;
            if c==0{
                s1=1;
            }if m>n{
                s2=-1;
                m=n-2;
            }
        }
        println!("{}",s);
        if let Err(e) = write(&s) {
            eprintln!("Error Writtinf {}", e);
        }
    
    } else {
        println!("Enter An Odd Number");
    }
}
