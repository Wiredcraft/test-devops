package devops

import "os/exec"

func NewFortune() ([]byte, error) {

	out, err := exec.Command("fortune").Output()

	if err != nil {
		return nil, err
	}

	return out, nil
}
