package devops

import (
	"bytes"
	"os"
	"os/exec"
	"path/filepath"
	"text/template"
	"time"
)

const (
	// yaml front matter
	POST_TEMPLATE = `---
date: "{{.Date}}"
title: "{{.Title}}"
---

> {{.Content}}
`
	MODE = 0755
)

type Post struct {
	Date    string
	Title   string
	Content string
}

func NewPost() error {

	// generate post content
	now := time.Now().Format("2006-01-02T15:04:05Z07:00")
	fortune, err := NewFortune()
	if err != nil {
		return err
	}
	content := string(fortune)
	p := Post{
		now,
		now,
		content,
	}
	var buf bytes.Buffer
	tpl, err := template.New(now).Parse(POST_TEMPLATE)
	if err != nil {
		return err
	}
	err = tpl.Execute(&buf, p)
	if err != nil {
		return err
	}

	// write to file
	uuid, err := uuid()
	if err != nil {
		return err
	}
	fp := filepath.Join("content", string(bytes.TrimSpace(uuid))+".md")
	f, err := os.OpenFile(fp, os.O_WRONLY|os.O_CREATE, MODE)
	if err != nil {
		return err
	}
	defer f.Close()

	_, err = f.WriteString(buf.String())
	if err != nil {
		return err
	}

	return nil
}

// use uuid as file name
func uuid() ([]byte, error) {

	out, err := exec.Command("uuidgen").Output()
	if err != nil {
		return nil, err
	}

	return out, nil
}
