package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"os"
	"runtime"
	"time"

	"github.com/shirou/gopsutil/cpu"
	"github.com/shirou/gopsutil/mem"
	"github.com/shirou/gopsutil/v3/disk"

	_ "github.com/lib/pq"
)

const (
	superUser     = "ps_user"
	superPassword = "SecurePassword"
	dbHost        = "localhost"
	dbName        = "weblogs"
	dbPort        = 5432
	dbUser        = "ps_user"
	dbPassword    = "SecurePassword"
)

func createDatabase(w http.ResponseWriter) {
	// Connect to default postgres DB to create target DB if needed
	superConnStr := fmt.Sprintf("host=%s port=%d user=%s dbname=ps_db sslmode=disable",
		dbHost, dbPort, superUser, superPassword)
	superDB, err := sql.Open("postgres", superConnStr)
	if err != nil {
		log.Fatalf("Failed to connect to postgres DB: %v", err)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	defer superDB.Close()

	// Create database if not exists
	_, err = superDB.Exec(fmt.Sprintf("CREATE DATABASE %s", dbName))
	if err != nil {
		if err.Error() != fmt.Sprintf(`pq: database "%s" already exists`, dbName) {
			log.Printf("Warning: %v", err)
		}
	}
}

func createTable(w http.ResponseWriter) {
	// Connect to database
	dbConnStr := fmt.Sprintf("host=%s port=%d user=%s password=%s dbname=%s sslmode=disable",
		dbHost, dbPort, dbUser, dbPassword, dbName)
	db, err := sql.Open("postgres", dbConnStr)
	if err != nil {
		log.Fatalf("Failed to connect to %s DB: %v", dbName, err)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	defer db.Close()

	// Create log table if not exists
	createTable := `
	CREATE TABLE IF NOT EXISTS logs (
		id SERIAL PRIMARY KEY,
		ip_address TEXT,
		method TEXT,
		path TEXT,
		user_agent TEXT,
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	);
	`

	_, err = db.Exec(createTable)
	if err != nil {
		log.Fatalf("Failed to create logs table: %v", err)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
}

func handler(w http.ResponseWriter, r *http.Request) {
	method := r.Method
	path := r.URL.Path
	ip := r.RemoteAddr
	userAgent := r.UserAgent()
	timestamp := time.Now().Format(time.RFC3339)

	// Create new database if not exists
	createDatabase(w)

	// Create new database table if not exists
	createTable(w)

	var db *sql.DB
	var err error
	psqlInfo := "host=" + dbHost +
		" port=" + string(rune(dbPort)) +
		" user=" + dbUser +
		" password=" + dbPassword +
		" dbname=" + dbName +
		" sslmode=disable"

	db, err = sql.Open("postgres", psqlInfo)
	if err != nil {
		log.Fatalf("Error connecting to database: %v", err)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	err = db.Ping()
	if err != nil {
		log.Fatalf("Database uncreachable: %v", err)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	_, err = db.Exec(`
		INSERT INTO logs (ip_address, method, path, user_agent)
		VALUES ($1, $2, $3, $4)
	`, ip, method, path, userAgent)

	if err != nil {
		log.Fatalf("Failed to insert log: %v", err)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

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
		
	Hello World from Docker and Kubernetes! v1.0.3
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
	fmt.Fprint(w, "\n")
	fmt.Fprintf(w, "Logged Request: [%s] %s %s from %s\n", timestamp, method, path, ip)
	fmt.Fprintf(w, "User Agent: %s\n", userAgent)
}

func main() {
	http.HandleFunc("/", handler)

	fmt.Println("Server listening on port 8081")
	log.Fatal(http.ListenAndServe(":8081", nil))
}
