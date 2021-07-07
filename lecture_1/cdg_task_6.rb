=begin
Написать скрипт, который будет принимать число и слово, если слово заканчивается на CS -
выводит на экран цифру 2 в степени (длинны введенного слова), если не заканчивается - выводит
слово задом наперед
=end

#Вариант 1 без использвания метода

print 'Введите число: '
#Ограничим вводенное значение числом
number = Integer(gets)

print 'Введите слово: '
word = gets.strip.upcase

puts word[(-2..-1)] == 'CS' ? 2 ** word.size : word.downcase.reverse

# if word[(-2..-1)] == 'CS'
#   puts 2 ** word.size
# else
#   puts word.downcase.reverse
# end

#Вариант 2 с использование метода

def number_and_word
  gets.strip
end