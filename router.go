// router.go
package main

import(
   "net/http"
   "github.com/asccclass/sherryserver"
   // "github.com/asccclass/apigateway/libs/proxy"
)

// Create your Router function
func NewRouter(srv *SherryServer.Server, documentRoot string)(*http.ServeMux) {
   router := http.NewServeMux()

   // Static File server
   staticfileserver := SherryServer.StaticFileServer{documentRoot, "index.html"}
   staticfileserver.AddRouter(router)

   return router
}

