#  Todo API Server 待辦事項

## 主要特色
* 完整的 CRUD 操作：
```
get_all_todos: 取得所有待辦事項
get_todo_by_id: 取得特定ID的待辦事項
create_todo: 新增待辦事項
update_todo: 修改待辦事項
delete_todo: 刪除待辦事項
```
* 線程安全：使用 sync.RWMutex 確保並發存取的安全性
* 內存存儲：使用 map 結構存儲 Todo 項目（可以後續擴展到數據庫）
* 錯誤處理：完整的參數驗證和錯誤處理

## Todo 結構
每個 Todo 項目包含：
```
ID: 自動生成的唯一識別碼
CreateDate: 自動設定的建立時間
Context: 待辦事項內容
User: 使用者名稱
DueTime: 到期時間
IsFinish: 完成狀態
```

## API 對應的 MCP 工具
* GET /todos → get_all_todos
* GET /todo/{id} → get_todo_by_id
* POST /todo → create_todo
* PUT /todo/{id} → update_todo
* DELETE /todo/{id} → delete_todo
