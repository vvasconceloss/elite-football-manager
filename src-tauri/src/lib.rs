use tokio::runtime::Runtime;

mod save;
mod database;

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    let save_name =  save::save_system::generate_save_name();

    let runtime_tokio = Runtime::new().expect("Failed create tokio runtime");
    let database_pool = runtime_tokio.block_on(database::connection::init_database(&save_name))
    .expect("Failed to initialize database");

    runtime_tokio.block_on(database::migration::execute_migrations(&database_pool));

    tauri::Builder::default()
        .plugin(tauri_plugin_opener::init())
        .manage(database_pool)
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}