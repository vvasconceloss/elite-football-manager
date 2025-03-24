use chrono::Local;

pub fn generate_save_name() -> String {
    let now = Local::now();
    format!("save_{}", now.format("%Y-%m-%d_%H-%M-%S"))
}