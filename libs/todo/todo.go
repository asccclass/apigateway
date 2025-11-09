package SherryTodo

import(
   "os"
   "fmt"
   "time"
   "net/http"
   "database/sql"
)

// Todo 代表 todo 資料表中的一個項目
type Todo struct {
   ID         int       `json:"id"`
   CreateDate time.Time `json:"createdate"`
   Context    string    `json:"context"`
   User       string    `json:"user"`
   DueTime    string	`json:"duetime"`
   IsFinish   string	`json:"isFinish"`
}

// TodoUpdate 用於部分更新的結構體，使用指標類型
type TodoUpdate struct {
   ID         *int       `json:"id"`
   CreateDate *time.Time `json:"createdate"`
   Context    *string    `json:"context"`
   User       *string    `json:"user"`
   DueTime    *string	`json:"duetime"`
   IsFinish   *string	`json:"isFinish"`
}

func(app *TodoService) Close() {
   app.DB.Close()
}

// todo service
type TodoService struct {
   DBPath	string
   DB		*sql.DB
}

func(app *TodoService) AddRouter(router *http.ServeMux) {
   router.HandleFunc("GET /todos", app.GetTodosFromWeb)
   router.HandleFunc("GET /todo/{id}", app.GetTodoFromWeb)
   router.HandleFunc("POST /todo", app.CreateTodoFromWeb)
   router.HandleFunc("PUT /todo/{id}", app.UpdateTodoFromWeb)
   router.HandleFunc("DELETE /todo/{id}", app.DeleteTodoFromWeb)
}

func NewTodo()(*TodoService, error) {
   db := &TodoService {
      DBPath: os.Getenv("DBPath") + os.Getenv("DBNAME"),
   }
   if err := db.InitialDB(); err != nil {
      fmt.Println("initial error:" + err.Error())
      return nil, err
   }
   fmt.Printf("db start at %s\n", db.DBPath)
   return db, nil
}
