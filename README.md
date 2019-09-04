# ruby_study_repo
repository for studying advanced ruby concepts such as metaprogramming and such

## RSpec guided

bundle install, then rpsec -fd (format documentation)
to see it pretty

## 1 understanding the Object model

![](https://i.stack.imgur.com/tBVGQ.png)

- Ruby always has a self (any part of your code is executable)
- if nothing has been called, self is the 'main'
- receiver (even if implicit)
- class self vs INSTANCE self (this is the instance self)

- methods belong to the class. Object.instance_methods
- attributes belong to the object

- Class.ancestors => [Class, Module, Object, Kernel, BasicObject]

- in Ruby, a Singleton (or Ghost class) is a method that only exists in one instance, but not others

- self.class.constants -> constants on main
- classes are no more than instances of 'Class' attributed to a constant



