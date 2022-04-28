package main

import (
	"io/ioutil"
	"log"

	"gopkg.in/yaml.v2"
)

var configFile []byte

type Config struct {
	Redis RedisConfig `yaml:"redis"`
}

type RedisConfig struct {
	Addr     string `yaml:"addr"`
	DataBase int    `yaml:"dataBase"`
	PassWord string `yaml:"passWord"`
}

// Get redis config from config.yaml
func getRedisConfig() (e *Config, err error) {
	configFile, err = ioutil.ReadFile("config.yaml")
	if err != nil {
		log.Fatalf("Config get err: %v!", err)
	}
	yaml.Unmarshal(configFile, &e)
	return e, err
}
