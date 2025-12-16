use std::ops::Index;

use clap::Parser;

use crate::walk_dir::walk_dir;
mod args;
mod validation;
mod walk_dir;

fn main() {
    println!("Printing Tree Structure...");
    let arguments = args::Args::parse();
    println!("{}", &arguments.directory);
    let mut completed_levels: Vec<u16> = vec![];
    walk_dir(&arguments.directory, arguments.depth, 1, &mut completed_levels);
}
