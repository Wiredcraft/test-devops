package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"sort"
	"strings"
)

type input struct {
	Name string `json:"name"`
}

func main() {
	//actionIds := task1()
	http.HandleFunc("/welcome", task4Handler)
	http.ListenAndServe(":8080", nil)
}

// Task1 corresponds with the Task 1. Scripting language, due to the log file is not standard json format that I have to spilt the whole file into serveral byte slices. Then reports whether it contains within "ongoing" and return the actionId.
func task1() []string {
	var actionIds []string
	f, err := ioutil.ReadFile("test.log")
	if err != nil {
		panic(err.Error())
	}
	lines := bytes.Split(f, []byte("replaced = "))
	for _, line := range lines {
		if bytes.Contains(line, []byte("ongoing")) {
			a := strings.Trim(string(line[bytes.Index(line, []byte(" \"")):]), " \"\n")
			actionIds = append(actionIds, a)
		}
	}
	sort.Strings(actionIds)
	return actionIds
}

// Task4Handler corresponds with the Task 4. It's a handler, with the listenAndServe in main function, it will start a HTTP server.
func task4Handler(w http.ResponseWriter, r *http.Request) {
	var in input
	switch r.Method {
	case "GET":
		param := r.URL.Query().Get("name")
		if param == "" {
			fmt.Fprintf(w, "hello Wiredcraft")
			return
		}
		fmt.Fprintf(w, "hello %v", param)
	case "PUT":
		b, _ := ioutil.ReadAll(r.Body)
		json.Unmarshal(b, &in)
		out, _ := json.Marshal(in.Name)
		fmt.Fprintf(w, "hello~%s", string(out))
	}
}
