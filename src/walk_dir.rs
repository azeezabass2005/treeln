use std::{fs, path::{Path}};

pub fn walk_dir(directory: &str, depth: i32, level: u16, mut completed_levels: &mut Vec<u16>) {
    if completed_levels.contains(&level) {
        completed_levels.retain(|a| a != &level);
    }
    let read_dir_result = fs::read_dir(directory);
    match read_dir_result {
        Ok(result) => {
            let mut result = result.peekable();
            while let Some(entry) = result.next() {
                let entry: fs::DirEntry = entry.unwrap();
                if let Some(name) = entry.path().to_str() {
                    let full_name = name.split("/").collect::<Vec<&str>>();
                    let mut indent = String::new();
                    for i in 0..level {
                        let indentation = " ".repeat(3);
                        if i != 0 && !completed_levels.contains(&i) {
                            let formatted_indent = format!("│{}", indentation);
                            indent.push_str(&formatted_indent);
                        } else  {
                            let formatted_indent = format!("{}", indentation);
                            indent.push_str(&formatted_indent);
                        }
                    };
                    if result.peek().is_none() {
                        completed_levels.push(level.into())
                    };
                    let level: usize = level.into();
                    let name = full_name.get(level);
                    if let Some(name) = name {
                        // ├── └──
                        if result.peek().is_none() {
                            let formatted_line = format!("{}└──{}", indent, name);
                            println!("{}", formatted_line);
                        } else {
                            let formatted_line = format!("{}├──{}", indent, name);
                            println!("{}", formatted_line);
                        }
                        
                    }
                };
                match entry.path().to_str() {
                    Some(ent) => {
                        if Path::new(ent).is_dir() && depth != 1 {
                            walk_dir(ent, depth - 1, level + 1, &mut completed_levels);
                        }
                    },
                    None => {}
                };
            };
        },
        Err(e) => {
            println!("An error occurred while reading director {}: {:?}", directory, e);
        }
    }
}