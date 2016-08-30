package devops

import "testing"

func TestBumpVersion(t *testing.T) {

	err := BumpVersion("dev")
	if err != nil {
		t.Errorf("E! %v", err)
	}

	err = BumpVersion("staging")
	if err != nil {
		t.Errorf("E! %v", err)
	}
}
