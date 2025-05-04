package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"runtime"
	"time"

	"github.com/shirou/gopsutil/cpu"
	"github.com/shirou/gopsutil/mem"
	"github.com/shirou/gopsutil/v3/disk"
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
		
	Hello World from Docker and Kubernetes! v1.0.2
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

	rootPath := "/"
	diskUsage, err := disk.Usage(rootPath)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	hostname, _ := os.Hostname()

	fmt.Fprint(w, "\n")
	fmt.Fprintf(w, "Hostname: %s", hostname)
	fmt.Fprint(w, "\n")
	fmt.Fprint(w, "OS Utilisation:\n")
	fmt.Fprintf(w, "Current CPU Usage: %.2f%%\n", cpuUsage[0])
	fmt.Fprintf(w, "Number of CPUs: %d\n", runtime.NumCPU())
	fmt.Fprintf(w, "Number of goroutines: %d\n", runtime.NumGoroutine())

	fmt.Fprintf(w, "Current Memory Usage: %.2f%%\n", memUsage.UsedPercent)
	fmt.Fprintf(w, "Disk Usage: Total: %d GB, Used: %d GB, Free: %d GB, Usage: %.2f%%\n", diskUsage.Total/1024/1024/1024, diskUsage.Used/1024/1024/1024, diskUsage.Free/1024/1024/1024, diskUsage.UsedPercent)
}

func main() {
	http.HandleFunc("/", handler)

	fmt.Println("Server listening on port 8081")
	log.Fatal(http.ListenAndServe(":8081", nil))
}
