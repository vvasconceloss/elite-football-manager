use directories::BaseDirs;
use std::{fs::{self, File}, io, path::PathBuf};

fn fetch_config_path() -> Option<PathBuf> {
    BaseDirs::new().map(|base_dirs| base_dirs.config_dir().to_path_buf())
}

fn create_database_files(config_path: PathBuf) -> std::io::Result<()> {
    let user_config_path = config_path.to_str().ok_or_else(||
        io::Error::new(
            io::ErrorKind::InvalidData, 
            "Path contains non-UTF-8 characters"
        )
    )?;

    let database_path = PathBuf::from(user_config_path)
    .join("EFM2025")
    .join("EFM2025.db");

    fs::create_dir_all(database_path.parent().unwrap())?;
    File::create(&database_path).ok();

    Ok(())
}

pub fn connect_database() {
    match fetch_config_path() {
        Some(config_path) => {
            match create_database_files(config_path) {
                Ok(()) => {},
                Err(e) => eprintln!("Failed to create the file: {}", e),
            }
        }
        None => eprintln!("Error: Configuration directory not found"),
    }
}