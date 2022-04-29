package main

import (
	"context"
	"log"
	"time"

	"github.com/go-redis/redis"
)

var rdb *redis.Client

// init redis config
func initClient() (err error) {
	config, err := getRedisConfig()
	if err != nil {
		log.Fatalf("Get config file error: %v", err)
	}
	rdb = redis.NewClient(&redis.Options{
		Addr:     config.Redis.Addr,
		Password: config.Redis.PassWord,
		DB:       config.Redis.DataBase,
	})

	_, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	_, err = rdb.Ping().Result()
	return err
}

// get key from redis
func redisGet(key string) (val string, err error) {
	if err = initClient(); err != nil {
		return
	}
	val, err = rdb.Get(key).Result()
	if err == redis.Nil {
		log.Println("name does not exist")
		return
	} else if err != nil {
		log.Println("get name failed, err:%v\n", err)
		return
	} else {
		return
	}
}

// set key
func redisSet(key string, value string) (err error) {
	err = rdb.Set(key, value, 0).Err()
	if err != nil {
		log.Panicf("Set failed, err:%v\n", err)
		return
	}
	return
}
