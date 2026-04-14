require_relative 'lib/hash_map'
require_relative 'lib/node'
require_relative 'lib/bucket'


test = HashMap.new
test.set('apple', 'red')#1
test.set('banana', 'yellow')#2
test.set('carrot', 'orange')#3
test.set('dog', 'brown')#4
test.set('elephant', 'gray')#5
test.set('frog', 'green')#6
test.set('grape', 'purple')#7
test.set('hat', 'black')#8
test.set('ice cream', 'white')#9
test.set('jacket', 'blue')#10
test.set('kite', 'pink')#11
test.set('lion', 'golden')#12 this is 12 from TOP
test.set('kite', 'purple')#12 replaces kite pink
test.set('moon', 'silver')#13
test.set('Julia', 'Roberts')#14
test.set('Julietta', 'Dunlop')#15
test.set('Julietta', 'XXXXX')#16 doesn't replace value
test.set('kite', 'XXXXX')# replaces value
test.set('moon', 'XXXXX')# replaces value
test.set('lion', 'XXXXX')# 17 doesn't replace value
test.set('jacket', 'XXXXX')# replaces value
test.set('hat', 'XXXXX')# replaces value



p "test.length = #{test.length}"
p test

p test.get('ralph')
p test.get('Julietta')
p test.length

p test.entries
p test.keys
p test.values