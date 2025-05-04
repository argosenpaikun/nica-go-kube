package main

import (
	"fmt"
	"log"
	"net/http"
	"runtime"
	"time"

	"github.com/shirou/gopsutil/cpu"
	"github.com/shirou/gopsutil/mem"
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
		
	Hello World from Docker and Kubernetes! v1.0.4
	`)

	cpuUsage, err := cpu.Percent(time.Second, false)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	memUsage, err := mem.VirtualMemory()
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	fmt.Fprint(w, "\n")
	fmt.Fprint(w, "OS Utilisation:\n")
	fmt.Fprintf(w, "Current CPU Usage: %.2f%%\n", cpuUsage[0])
	fmt.Fprintf(w, "Number of CPUs: %d\n", runtime.NumCPU())
	fmt.Fprintf(w, "Number of goroutines: %d\n", runtime.NumGoroutine())

	fmt.Fprintf(w, "Current Memory Usage: %.2f%%", memUsage.UsedPercent)
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
