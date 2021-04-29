package main

import (
	"fmt"
	"net/http"
)

// rtrText just return success for any request
func RtnText(w http.ResponseWriter, req *http.Request) {
	fmt.Println("Get Request...")
	defer req.Body.Close()
	w.Write([]byte("{\"request\":\"success\"}"))
}

func main() {
	http.HandleFunc("/", RtnText)
	http.ListenAndServe(":8080", nil)
}
