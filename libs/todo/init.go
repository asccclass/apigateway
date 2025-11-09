package SherryTodo

import(
   "os"
   "fmt"
   "path/filepath"
   "database/sql"
   _ "modernc.org/sqlite"
)

// 初始化資料庫
func(app *TodoService) InitialDB()(error) {
   dir := filepath.Dir(app.DBPath)
   if _, err := os.Stat(dir); os.IsNotExist(err) {
      fmt.Println("Creating database directory...")
      if err := os.MkdirAll(dir, os.ModePerm); err != nil {
         return err
      }
   }
   if _, err := os.Stat(app.DBPath); os.IsNotExist(err) {   // "/app/data/todo.db"
      fmt.Println("Creating database file...")
      file, err := os.Create(app.DBPath)
      if err != nil {
         return err
      }
      defer file.Close()
   }
   db, err := sql.Open("sqlite", app.DBPath)
   if err != nil {
      return err
   }
   app.DB = db
   // 建立資料表
   createTableSQL := `
    CREATE TABLE IF NOT EXISTS todo (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        createdate DATETIME,
        context TEXT,
        user TEXT,
        duetime DATETIME,
        isFinish TEXT 
    );`
    _, err = app.DB.Exec(createTableSQL)
   if err != nil {
      return err
   }
   return nil
}
