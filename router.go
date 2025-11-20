// router.go
package main

import(
   "fmt"
   "net/http"
   "github.com/asccclass/sherryserver"
   "github.com/asccclass/apigateway/libs/weather"
)

// Create your Router function
func NewRouter(srv *SherryServer.Server, documentRoot string)(*http.ServeMux) {
   router := http.NewServeMux()

   // Static File server
   staticfileserver := SherryServer.StaticFileServer{documentRoot, "index.html"}
   staticfileserver.AddRouter(router)

   // Weather service
   ws, err := SherryWeather.NewWeatherService()
   if err != nil {
      fmt.Println(err.Error())
   } else {
      ws.AddRouter(router)
   }
   return router
}

