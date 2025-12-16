use std::path::Path;

pub fn parse_directory(val: &str) -> Result<String, String> {
    if Path::new(val).is_dir() {
        Ok(val.to_string())
    } else {
        Err("Please enter a valid directory".to_string())
    }
}