package devops

import "testing"

func TestNewPost(t *testing.T) {

	err := NewPost()
	if err != nil {
		t.Errorf("E! %v", err)
	}
}
