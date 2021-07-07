=begin
Написать скрипт, который будет принимать число и слово, если слово заканчивается на CS -
выводит на экран цифру 2 в степени (длинны введенного слова), если не заканчивается - выводит
слово задом наперед
=end

#Вариант 2 c использванием метода

def number_and_word
  gets.strip
end

print 'Введите число: '
number = number_and_word.to_i

print 'Введите слово: '
word = number_and_word.upcase

puts word[(-2..-1)] == 'CS' ? 2 ** word.size : word.downcase.reverse

