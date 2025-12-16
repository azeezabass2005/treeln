use clap::Parser;

use crate::validation::parse_directory;

/// A command line application to print the tree structure of a directory
#[derive(Parser, Debug)]
#[command(version, about, long_about = None)]
pub struct Args {
    /// The directory the user wants to print tree for (defaults to pwd)
    #[arg(short, long, default_value = ".", value_parser = parse_directory)]
    pub directory: String,

    /// How deep the user wants the tree to be printed (defaults to 5)
    #[arg(short = 'D', long, default_value = "2")]
    pub depth: i32,
}