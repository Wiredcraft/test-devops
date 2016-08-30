package devops

import (
	"os"
	"os/exec"
	"strconv"
	"strings"

	"github.com/BurntSushi/toml"
)

type config struct {
	BaseUrl string `toml:"baseurl"`
	Title   string `toml:"title"`
	Theme   string `toml:"theme"`
	Params  params `toml:"params"`
}

type params struct {
	Version string `toml:"version"`
}

const (
	CONFIG_FILE = "config.toml"

	DEV     = "dev"
	STAGING = "staging"

	DOT = "."
)

const (
	ONE = iota + 1
	TWO
)

func BumpVersion(action string) error {

	// read config.toml in current directory
	var cfg config
	_, err := toml.DecodeFile(CONFIG_FILE, &cfg)
	if err != nil {
		return err
	}
	version := cfg.Params.Version
	numSlice := strings.Split(version, DOT)
	switch action {
	case DEV:

		v, err := strconv.Atoi(numSlice[len(numSlice)-ONE])
		if err != nil {
			return err
		}
		v += 1
		numSlice[len(numSlice)-ONE] = strconv.Itoa(v)

	case STAGING:

		v, err := strconv.Atoi(numSlice[len(numSlice)-TWO])
		if err != nil {
			return err
		}

		v += 1
		numSlice[len(numSlice)-TWO] = strconv.Itoa(v)
		numSlice[len(numSlice)-ONE] = "0"

	default:

		return ErrParamType
	}

	cfg.Params.Version = strings.Join(numSlice, DOT)
	f, err := os.OpenFile(CONFIG_FILE, os.O_WRONLY|os.O_CREATE, MODE)
	if err != nil {
		return err
	}
	defer f.Close()

	// write version back to config.toml
	return toml.NewEncoder(f).Encode(cfg)
}

// get current site version (used in git tag)
func Version(action string) (string, error) {

	var cfg config
	_, err := toml.DecodeFile(CONFIG_FILE, &cfg)
	if err != nil {
		return "", err
	}
	return cfg.Params.Version, nil
}

// compile the site
func Compile() error {

	_, err := exec.Command("hugo", "-v").Output()
	return err
}
