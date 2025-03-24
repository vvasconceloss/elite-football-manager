mod database;

use tokio::runtime::Runtime;

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    let runtime_tokio = Runtime::new().expect("Failed create tokio runtime");
    let database_pool = runtime_tokio.block_on(database::connection::init_database())
    .expect("Failed to initialize database");

    tauri::Builder::default()
        .plugin(tauri_plugin_opener::init())
        .manage(database_pool)
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}