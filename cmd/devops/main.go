package main

import (
	"flag"
	"fmt"
	"os"

	"github.com/xuqingfeng/devops"
)

const (
	VERSION = "0.3.0"
)

func main() {

	version := flag.Bool("v", false, "version")

	flag.Parse()

	if *version {
		fmt.Printf("%s\n", VERSION)
		os.Exit(0)
	}

	if len(flag.Args()) != 1 {
		fmt.Printf("E! %v\n", devops.ErrParamNum)
		os.Exit(1)
	}

	param := flag.Arg(0)

	switch param {
	case devops.DEV:
		err := devops.NewPost()
		exitOnErr(err)

		err = devops.BumpVersion(param)
		exitOnErr(err)

		err = devops.Compile()
		exitOnErr(err)

		err = devops.Commit()
		exitOnErr(err)

		err = devops.Push()
		exitOnErr(err)

	case devops.STAGING:
		err := devops.BumpVersion(param)
		exitOnErr(err)

		err = devops.Compile()
		exitOnErr(err)

		err = devops.Commit()
		exitOnErr(err)

		siteVersion, err := devops.Version(param)
		exitOnErr(err)

		err = devops.Tag(siteVersion)
		exitOnErr(err)

		err = devops.Push()
		exitOnErr(err)

		err = devops.PushTag()
		exitOnErr(err)

	default:
		fmt.Printf("E! %v\n", devops.ErrParamType)
		os.Exit(1)
	}
}

func exitOnErr(err error) {

	if err != nil {
		fmt.Printf("E! %v\n", err)
		os.Exit(1)
	}
}
