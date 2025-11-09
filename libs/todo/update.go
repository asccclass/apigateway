package SherryTodo

import(
   "fmt"
   "strings"
   "strconv"
   "net/http"
   "io/ioutil"
   "encoding/json"
)

// 更新現有的 todo 項目
func(app *TodoService) UpdateTodoFromWeb(w http.ResponseWriter, r *http.Request) {
   idw := r.PathValue("id")
   if idw == "" {
      app.respondWithError(w, http.StatusBadRequest, "Invalid todo ID")
      return
   }
   id, err := strconv.Atoi(idw)
   if err != nil {
      app.respondWithError(w, http.StatusBadRequest, "Invalid todo ID to int")
      return
   }
   b, err := ioutil.ReadAll(r.Body)
   defer r.Body.Close()
   if err != nil {
      app.respondWithError(w, http.StatusBadRequest, "Invalid json")
      return
   } 
   // 依據欄位產生SQL資料
   var update map[string]interface{}
   if err = json.Unmarshal(b, &update); err != nil {
      fmt.Println("decode error:", err.Error())
      app.respondWithError(w, http.StatusBadRequest, "Invalid request payload")
      return
   }
   delete(update, "id")  // 移除 id 欄位，因為它不應該被更新
   // 定義允許更新的欄位
   allowedFields := map[string]string{
      "context":  "context",
      "user":     "user",
      "duetime":  "duetime",
      "isFinish": "isFinish",
      "createdate": "createdate",
   }

   // 建立動態 SQL 查詢
   var args []interface{}
   var setParts []string
   for jsonField, value := range update {
      if dbField, exists := allowedFields[jsonField]; exists {
         if value != "" || (dbField == "createdate" && value != "0001-01-01T00:00:00Z") {
            setParts = append(setParts, fmt.Sprintf("%v = ?", dbField))
	    args = append(args, value)
         }
      }
   }
   if len(setParts) == 0 {
      fmt.Println("decode error")
      app.respondWithError(w, http.StatusBadRequest, "No data to update")
      return
   }
   // 建立完整的 SQL 語句
   query := fmt.Sprintf("update todo set %s WHERE id = ?", strings.Join(setParts, ", "))
   args = append(args, id)

   stmt, err := app.DB.Prepare(query)
   if err != nil {
      fmt.Println("Update todo error:" + err.Error())
      app.respondWithError(w, http.StatusInternalServerError, err.Error())
      return
   }
   defer stmt.Close()
   _, err = stmt.Exec(args...)
   if err != nil {
      fmt.Println("Run todo update todo error:" + err.Error())
      app.respondWithError(w, http.StatusInternalServerError, err.Error())
      return
   }
   app.respondWithJSON(w, http.StatusOK, update)
}
