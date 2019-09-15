# RUBY METAPROGRAMMING AS SPEC


- repository for studying advanced ruby concepts such as metaprogramming and such
- use code instead of text to explain myself

## References

- [Ruby Metaprogramming](https://amzn.to/2LvxbKU)
- [Eloquent Ruby](https://amzn.to/2O3azTN)

## RSpec guided

-  bundle install, then rpsec -fd (format documentation)

## 1: Understanding the Object model

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

## 2 Blocks / Scope operations

- modudle, class and def change the scope
- by using new, you can "flatten" the scope, therefore using variables from other scopes
- Blocks vs Procs/Lambdas: Procs and Lambdas can be passed around, cause they are objects

## 3 Classes

- As there's always a self, there's always a class
- The class of main is Object
- methods defined with "def" become binded to the current class



