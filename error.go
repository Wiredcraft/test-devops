package devops

import "errors"

var (
	ErrParamNum  = errors.New("one parameter only")
	ErrParamType = errors.New("wrong parameter")
)
