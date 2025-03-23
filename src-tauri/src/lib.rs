mod database;

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    database::connection::connect_database();

    tauri::Builder::default()
        .plugin(tauri_plugin_opener::init())
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
