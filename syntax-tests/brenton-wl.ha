// License: MPL-2.0
// (c) 2022 Nixon Enraght-Moony

use fmt;

fn use() {
    fmt::println("Using");
}

fn escapes() {
    let x: str = "\0 \x234 \uaaaaa \Ufffffffff";
    let z: char = 'a';
    let y: char = '\0'; 

    let n = 7e7i8;
    let f = 8.6;
    let f2 = 8.6f64; 
    let bin = 0b00110;

    let b = true;
}