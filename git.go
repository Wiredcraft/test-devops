package devops

import "os/exec"

// commit, tag, push, push tag

func Commit() error {

	_, err := exec.Command("git", "add", ".").Output()
	if err != nil {
		return err
	}
	_, err = exec.Command("git", "commit", "-m", "chore: devops auto commit").Output()
	return err
}

func Tag(version string) error {

	_, err := exec.Command("git", "tag", "-a", version, "-m", version).Output()
	return err
}

func Push() error {

	_, err := exec.Command("git", "push", "-u", "origin", "master").Output()
	return err
}

func PushTag() error {

	_, err := exec.Command("git", "push", "origin", "--tags").Output()
	return err
}
