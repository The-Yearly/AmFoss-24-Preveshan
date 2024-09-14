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

fn main() -> io::Result<()> {
    let contents = match read() {
        Ok(contents) => contents,
        Err(e) => {
            eprintln!("ErrorReading {}", e);
            return Err(e);
        },
    };

    println!("{}", contents);
    if let Err(e) = write(&contents) {
        eprintln!("Error Writtinf {}", e);
    }

    Ok(())
}
