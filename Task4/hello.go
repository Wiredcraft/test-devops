package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
)

type helloName struct {
	Name string `json:"name"`
}

var nameCache string
var name helloName
var nameFromDB string

const DEFAULT_MSG string = "Hello, Wiredcraft!"

// GetMethod: get name from cache or db(cache does not exit)
func GetMethod(w http.ResponseWriter) {
	if nameCache == "" {
		log.Println("Cache does not exist")
		nameFromDB, err := redisGet("name")
		if err != nil {
			log.Panicf("Get value failed,err:%v", err)
			log.Printf("Return DEFAULT_MSG.")
		}
		if nameFromDB == "" {
			log.Println("DB is null")
			fmt.Fprint(w, DEFAULT_MSG)
		} else {
			nameCache = nameFromDB
			fmt.Fprint(w, "Hello,"+nameFromDB+"!")
		}
	} else {
		log.Println("cache is not null")
		fmt.Fprint(w, "Hello,"+nameCache+"!")
	}
}

// PutMethod: get name from request body ,and set it in db and cache
func PutMethod(w http.ResponseWriter, r *http.Request) {
	body, err := ioutil.ReadAll(r.Body)
	if err != nil {
		log.Panicf("read body err, %v\n", err)
		return
	}
	json.Unmarshal([]byte(string(body)), &name)
	nameCache = name.Name
	err = redisSet("name", nameCache)
	if err != nil {
		log.Panicf("set db failed,err:%v", err)
	} else {
		log.Println("set db successful")
	}
}

func SayHelloName(w http.ResponseWriter, r *http.Request) {
	if r.Method == "GET" {
		log.Println("Method:Get")
		GetMethod(w)
	} else if r.Method == "PUT" {
		log.Println("Method:Put")
		PutMethod(w, r)
	} else {
		log.Printf("Only support Get and Put,but : %s", r.Method)
		return
	}
}

func main() {
	http.HandleFunc("/welcome", SayHelloName)
	err := http.ListenAndServe(":9090", nil)
	if err != nil {
		log.Printf("Http server faild,err:%v\n", err)
		return
	}
}
