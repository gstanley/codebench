def ruby_to_meta(code)
end

def javascript_to_meta(code)
end

=begin
* wrappers
1.class # => Fixnum: the number 1 is a Fixnum
** doc
invoke a method
** location
*** path/file
book:The Ruby Programming Language
*** lineno
1.1.1
** index
A000000
** keywords
call method
fixnum
class
numeric literal
** undo
<none>
** custom setup/teardown
** assertion/test
result = 1.class
assert_equal(Fixnum, result)
** dependency list
** sensor list
** replace dependencies
*** from list
*** from generator
** replace code
*** alternate code
** inputs
*** classes
*** examples
** execution count
=end

