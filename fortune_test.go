package devops

import "testing"

func TestNewFortune(t *testing.T) {

	fortune, err := NewFortune()
	if err != nil {
		t.Errorf("E! %v", err)
	}
	if len(fortune) < 1 {
		t.Error("fortune is empty")
	}
}
