package core

type IsEvenError struct {
	IsIsEvenError bool
	Sdk              string
	Code             string
	Msg              string
	Ctx              *Context
	Result           any
	Spec             any
}

func NewIsEvenError(code string, msg string, ctx *Context) *IsEvenError {
	return &IsEvenError{
		IsIsEvenError: true,
		Sdk:              "IsEven",
		Code:             code,
		Msg:              msg,
		Ctx:              ctx,
	}
}

func (e *IsEvenError) Error() string {
	return e.Msg
}
