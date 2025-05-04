package main

import (
	"fmt"
	"log"
	"net/http"
	"runtime"
	"time"
)

func handler(w http.ResponseWriter, r *http.Request) {

	fmt.Println(r.URL.RawQuery)
	fmt.Fprint(w, `
			##         .
		## ## ##        ==
	## ## ## ## ##    ===
	/"""""""""""""""""\___/ ===
	{                       /  ===-
	\______ O           __/
	\    \         __/
	\____\_______/
		
	Hello World from Docker and Kubernetes! v1.0.1
	`)
}

func main() {
	http.HandleFunc("/", handler)

	go func() {
		for {
			time.Sleep(1 * time.Second)
		}
	}()

	fmt.Println("Server listening on port 8081")
	log.Fatal(http.ListenAndServe(":8081", nil))
}
