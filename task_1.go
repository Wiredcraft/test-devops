package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"os"
	"sort"
	"strconv"
	"strings"
	"sync"
)

var (
	errorLogLineList = []int{}
	outputDataList   = []int{}
	wg               sync.WaitGroup
)

type idsLog struct {
	id     string
	status string
	accexp string
}

func handle(data []string, id int) {
	replaceBody, actionId, flag := []idsLog{}, "", false
	for _, _d := range data {
		_data := strings.Split(_d, "=")
		if len(_data) != 2 {
			errorLogLineList = append(errorLogLineList, id)
		}
		if strings.TrimSpace(_data[0]) == "replaced" {
			if err := json.Unmarshal([]byte(_data[1]), &replaceBody); err != nil {
				flag = true
			}
		}
		if strings.TrimSpace(_data[0]) == "actionId" {
			actionId = strings.TrimSpace(_data[1])
		}
	}
	if flag {
		_actionId , err := strconv.Atoi(strings.Trim(actionId, "\""))
		if err != nil {
			errorLogLineList = append(errorLogLineList, id)
		}
		outputDataList = append(outputDataList, _actionId)
	}
	wg.Done()
}

func readfile(fileName string) error {
	f, err := os.Open(fileName)
	if err != nil {
		return err
	}
	defer f.Close()
	buf, id, tmp := bufio.NewReader(f), 0, []string{}
	for {
		id++
		line, err := buf.ReadString('\n')
		line = strings.TrimSpace(line)
		if err != nil {
			if err == io.EOF {
				return nil
			}
			return err
		}
		if strings.HasPrefix(line, "replaced") {
			tmp = append(tmp, line)
		} else if strings.HasPrefix(line, "actionId") {
			tmp = append(tmp, line)
			wg.Add(1)
			go handle(tmp, id)
			tmp = []string{}
		} else {
			errorLogLineList = append(errorLogLineList, id)
		}
	}
}

func writefile(filename string) error {
	sort.Ints(outputDataList)

	f, err := os.OpenFile(filename, os.O_WRONLY|os.O_CREATE, 0666)
	if err != nil {
		return err
	}
	defer f.Close()

	for _, data := range outputDataList {
		write := bufio.NewWriter(f)
		_, err = write.WriteString(strconv.Itoa(data) + "\r\n")
		if err != nil {
			return err
		}
		err = write.Flush()
		if err != nil {
			return err
		}
	}
	return nil
}

func main() {
	if err := readfile("data/test-1-action-ids.log"); err != nil {
		log.Fatalln(err)
	}
	wg.Wait()
	fmt.Println("cannot read line list:", errorLogLineList)
	if err := writefile("data/test-1-action-ids-answer-sheet.txt"); err != nil {
		log.Fatalln(err)
	}
}
