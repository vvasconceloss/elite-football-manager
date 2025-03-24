use directories::UserDirs;
use std::{fs::{self, File}, io, path::PathBuf};
use sqlx::{sqlite::SqlitePoolOptions, SqlitePool};

fn fetch_config_path() -> Option<PathBuf> {
    UserDirs::new().map(|base_dirs| base_dirs.document_dir().unwrap().to_path_buf())
}

fn config_database_files(config_path: PathBuf, save_name: &str) -> std::io::Result<PathBuf> {
    let user_config_path = config_path.to_str().ok_or_else(||
        io::Error::new(
            io::ErrorKind::InvalidData, 
            "Path contains non-UTF-8 characters"
        )
    )?;

    let database_path = PathBuf::from(user_config_path)
    .join("ProPlay Games")
    .join("Elite Football Manager 2025")
    .join("games")
    .join(format!("{}.efm", save_name));

    fs::create_dir_all(database_path.parent().unwrap())?;
    File::create(&database_path).ok();

    Ok(database_path)
}

async fn create_database(save_name: &str) -> Result<PathBuf, String> {
    match fetch_config_path() {
        Some(config_path) => match config_database_files(config_path.clone(), save_name) {
                Ok(database_path) => Ok(database_path),
                Err(e) => Err(format!("Failed to create the file: {}", e))
        },
        None => Err("Configuration directory not found".to_string())
    }
}

pub async fn init_database(save_name: &str) -> Result<SqlitePool, String> {
    let database_path = create_database(save_name).await?;
    let connection_string = format!("sqlite:{}", database_path.display());

    SqlitePoolOptions::new()
        .connect(&connection_string)
        .await
            .map_err(|e| format!("Failed to connect to database: {}", e))
}