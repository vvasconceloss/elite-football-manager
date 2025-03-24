use sqlx::{migrate, Pool, Sqlite};

pub async fn execute_migrations(pool: &Pool<Sqlite>) {    
    migrate!("src/database/migrations").run(pool).await.expect("Error running DB migrations");
}