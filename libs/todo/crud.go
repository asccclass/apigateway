package SherryTodo

import(
   "fmt"
   "time"
   "strconv"
   "net/http"
   "database/sql"
   "encoding/json"
)

// 獲取所有 todo 項目 ID、CreateDate、Context、User、DueTime、IsFinish
func(app *TodoService) GetTodosFromWeb (w http.ResponseWriter, r *http.Request) {
   rows, err := app.DB.Query("SELECT id, createdate, amount, title, context, user, duetime, isFinish FROM todo order by duetime")
   if err != nil {
      app.respondWithError(w, http.StatusInternalServerError, err.Error())
      return
   }
   defer rows.Close()
   todos := []Todo{}
   for rows.Next() {
      var t Todo
      var createDate, dueTime string
      err := rows.Scan(&t.ID, &createDate, &t.Amount, &t.Title, &t.Context, &t.User, &dueTime, &t.IsFinish)
      if err != nil {
         app.respondWithError(w, http.StatusInternalServerError, err.Error())
         return
      }
      // 解析時間字串
      t.CreateDate, _ = time.Parse(time.RFC3339, createDate)
      t.DueTime = dueTime
      todos = append(todos, t)
   }
   app.respondWithJSON(w, http.StatusOK, todos)
}

// 獲取單個 todo 項目
func(app *TodoService) GetTodoFromWeb(w http.ResponseWriter, r *http.Request) {
   id := r.PathValue("id")
   if id == "" {
      app.respondWithError(w, http.StatusBadRequest, "Invalid todo ID")
      return
   }

   var t Todo
   var createDate, dueTime string
   err := app.DB.QueryRow("SELECT id, createdate, amount, title, context, user, duetime, isFinish FROM todo WHERE id = ?", id).
         Scan(&t.ID, createDate, &t.Amount, &t.Title, &t.Context, &t.User, &dueTime, &t.IsFinish)

   if err != nil {
      if err == sql.ErrNoRows {
         app.respondWithError(w, http.StatusNotFound, "Todo not found")
         return
      }
      fmt.Println(err.Error())
      app.respondWithError(w, http.StatusInternalServerError, err.Error())
      return
   }

   // 解析時間字串
   t.CreateDate, _ = time.Parse(time.RFC3339, createDate)
   // t.DueTime, _ = time.Parse(time.RFC3339, dueTime)
   t.DueTime = dueTime

   app.respondWithJSON(w, http.StatusOK, t)
}

// 創建新的 todo 項目
func(app *TodoService) CreateTodoFromWeb(w http.ResponseWriter, r *http.Request) {
   var t Todo
   decoder := json.NewDecoder(r.Body)
   if err := decoder.Decode(&t); err != nil {
      app.respondWithError(w, http.StatusBadRequest, "Invalid request payload." + err.Error())
      return
   }
   defer r.Body.Close()
   // 如果未提供創建日期，使用當前時間
   if t.CreateDate.IsZero() {
      t.CreateDate = time.Now()
   }
   // 插入新記錄
   stmt, err := app.DB.Prepare("INSERT INTO todo(amount, title, createdate, context, user, duetime, isFinish) VALUES(?,?,?,?,?,?,?)")
   if err != nil {
      app.respondWithError(w, http.StatusInternalServerError, err.Error())
      return
   }
   defer stmt.Close()

   var dt time.Time
   dtemp, err := time.Parse("2006-01-02T15:04", t.DueTime)
   if err != nil {
      fmt.Println("解析失敗:", err.Error())
      dt = t.CreateDate
   } else {
      dt = dtemp
   }

   // result, err := stmt.Exec(t.CreateDate.Format(time.RFC3339), t.Context, t.User, t.DueTime.Format(time.RFC3339), t.IsFinish)
   result, err := stmt.Exec(t.Amount, t.Title, t.CreateDate.Format(time.RFC3339), t.Context, t.User, dt, t.IsFinish)
   if err != nil {
      app.respondWithError(w, http.StatusInternalServerError, err.Error())
      return
   }

   // 獲取新插入的記錄的 ID
   id, err := result.LastInsertId()
   if err != nil {
      app.respondWithError(w, http.StatusInternalServerError, err.Error())
      return
   }

   t.ID = int(id)
   app.respondWithJSON(w, http.StatusCreated, t)
}

// 刪除 todo 項目
func(app *TodoService) DeleteTodoFromWeb(w http.ResponseWriter, r *http.Request) {
   idw := r.PathValue("id")
   if idw == "" {
      app.respondWithError(w, http.StatusBadRequest, "Invalid todo ID")
      return
   }
   id, err := strconv.Atoi(idw)
   if err != nil {
      app.respondWithError(w, http.StatusBadRequest, "Invalid todo ID")
      return
   }
   // 刪除記錄
   stmt, err := app.DB.Prepare("DELETE FROM todo WHERE id=?")
   if err != nil {
      app.respondWithError(w, http.StatusInternalServerError, err.Error())
      return
   }
   defer stmt.Close()

   _, err = stmt.Exec(id)
   if err != nil {
      app.respondWithError(w, http.StatusInternalServerError, err.Error())
      return
   }
   app.respondWithJSON(w, http.StatusOK, map[string]string{"result": "success"})
}
