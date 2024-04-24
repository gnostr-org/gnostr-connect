// TEMPORARILY
#![allow(clippy::uninlined_format_args)]

use gnostr_types::PrivateKey;
use zeroize::Zeroize;

// Turn a hex private key into an encrypted private key
fn main() {
    if cfg!(debug_assertions) {
        println!("WARNING: This takes a long time in debug mode.");
    }

    let private_key_str = rpassword::prompt_password("Private Key (hex or bech32): ").unwrap();

    let private_key = match PrivateKey::try_from_hex_string(&private_key_str) {
        Ok(pk) => pk,
        Err(_) => match PrivateKey::try_from_bech32_string(&private_key_str) {
            Ok(pk) => pk,
            Err(_) => panic!("Did not recognize private key"),
        },
    };

    println!("Enter the logN rounds (a power of 2, e.g. 20): ");
    let mut log_n = String::new();
    let stdin = std::io::stdin();
    stdin.read_line(&mut log_n).unwrap();
    log_n = log_n.trim().to_string();
    let log_n = log_n.parse::<u8>().unwrap();

    let mut password = rpassword::prompt_password("Password: ").unwrap();

    let encrypted_private_key = private_key
        .export_encrypted(&password, log_n)
        .expect("Could not export encrypted private key");
    println!("Encrypted private key: {}", encrypted_private_key);
    password.zeroize();
}
