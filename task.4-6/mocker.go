package main

import (
	"fmt"
	"log"
	"net/http"
	"sync/atomic"
)

// Simple request count mock server.
type Counter struct {
	n int64
}

func (c *Counter) ServeHTTP(w http.ResponseWriter, req *http.Request) {
	atomic.AddInt64(&c.n, 1)
	fmt.Fprintf(w, "counter = %d\n", c.n)
}


func main() {
	ctr := new(Counter)
	http.Handle("/counter", ctr)

	log.Println("Start server listen on port 3000...")
	http.ListenAndServe(":3000", nil)
}
