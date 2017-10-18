:lib github.com/kovetskiy/manul-test-foo
:lib github.com/kovetskiy/manul-test-bar

:project "main.go" <<GO
package main

import "github.com/kovetskiy/manul-test-foo"
import "github.com/kovetskiy/manul-test-bar"

func main() {
    foo.Foo()
    bar.Bar()
}
GO

tests:ensure :manul -I
tests:ensure :manul -Q \| sort -n

tests:assert-no-diff stdout <<VENDORS
github.com/kovetskiy/manul-test-bar  9a5d4e050e8660fe7b616ce503e7c80a04e1e2db
github.com/kovetskiy/manul-test-foo  9e1daede0e52ef8b214555d14431372672ab6be5
VENDORS

tests:ensure :manul -R github.com/kovetskiy/manul-test-bar
#tests:assert-stdout "removed 1 submodules"
tests:assert-stderr "removing vendor github.com/kovetskiy/manul-test-bar"

tests:ensure :manul -Q
tests:assert-no-diff stdout <<VENDORS
github.com/kovetskiy/manul-test-bar
github.com/kovetskiy/manul-test-foo  9e1daede0e52ef8b214555d14431372672ab6be5
VENDORS
