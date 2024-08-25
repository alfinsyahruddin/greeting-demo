uniffi::setup_scaffolding!();

#[uniffi::export]
fn get_message() -> String {
    String::from("Hello from Rust! 🦀")
}
