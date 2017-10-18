:project "main.go" <<GO
package main

import "github.com/kovetskiy/manul-test-foo"

func main() {
    bar.A()
}
GO

:lib "github.com/kovetskiy/manul-test-foo"

tests:ensure :manul -I github.com/kovetskiy/manul-test-foo=3c2b599 -v
tests:assert-stderr "added 1 submodule"

tests:assert-stderr "adding submodule for github.com/kovetskiy/manul-test-foo"

tests:ensure git -C vendor/github.com/kovetskiy/manul-test-foo rev-parse --short=7 HEAD
tests:assert-stdout "3c2b599"
