require_relative 'lib/hash_map'
require_relative 'lib/node'
require_relative 'lib/bucket'
require_relative 'lib/hash_set'


# test = HashMap.new
# test.set('apple', 'red')#1
# test.set('banana', 'yellow')#2
# test.set('carrot', 'orange')#3
# test.set('dog', 'brown')#4
# test.set('elephant', 'gray')#5
# test.set('frog', 'green')#6
# test.set('grape', 'purple')#7
# test.set('hat', 'black')#8
# test.set('ice cream', 'white')#9
# test.set('jacket', 'blue')#10
# test.set('kite', 'pink')#11
# test.set('lion', 'golden')#12 this is 12 from TOP
# test.set('kite', 'purple')#12 replaces kite pink
# test.set('moon', 'silver')#13
# test.set('Julia', 'Roberts')#14
# test.set('Julietta', 'Dunlop')#15
# test.set('Julietta', 'Pulietta')#16 doesn't replace value
# test.set('kite', 'has flown away')# replaces value
# test.set('moon', 'river')# replaces value
# test.set('lion', 'with a big main')# 17 doesn't replace value
# test.set('jacket', 'ooh so comfy')# replaces value
# test.set('hat', 'rat-a-tat-tat')# replaces value


# p test
# p test.locate("Julietta")
# p test.get("ralph")
# p test.get('Julietta')
# p test.get('grape')
# p test.remove("hat")
# p test.length
# p test.keys
# p test.values


# p test.entries
# p test.clear

extra = HashSet.new
p extra.set("red")
p extra.set("Swanson")
p extra.set("Midge")
p extra.set("Marjoery")
p extra.set("Mellanie")
p extra.set("Mindy")
p extra.set("Martha")
p extra.set("Maggie")
p extra.set("Stephanie")
p extra.set("Aurora")
p extra.set("Alice")
p extra.set("Barbara")
p extra.set("Celeste")
p extra.set("Denise")
p extra.set("Ebony")
p extra.set("Franceen")
p extra.keys
p extra.entries
p extra.values
p extra.get("Franceen")
p extra.has?("Franceen")

p extra