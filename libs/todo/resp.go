package SherryTodo

import(
   "net/http"
   "encoding/json"
)

// 以 JSON 格式發送回應
func(app *TodoService) respondWithJSON(w http.ResponseWriter, code int, payload interface{}) {
   response, _ := json.Marshal(payload)
   w.Header().Set("Content-Type", "application/json")
   w.WriteHeader(code)
   w.Write(response)
}

// 發送錯誤訊息
func(app *TodoService) respondWithError(w http.ResponseWriter, code int, message string) {
   app.respondWithJSON(w, code, map[string]string{"error": message})
}
