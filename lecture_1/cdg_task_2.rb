=begin
Написать скрипт, который будет запрашивать имя фамилию и возраст, а затем выдавать приветствие
в одном из двух вариантов в зависимости от возраста:
Привет имя фамилия. Тебе меньше 18, но учиться программировать никогда не рано.
Привет имя фамилия. Самое время заняться делом!.
=end

# Вариант 2 c использованием метода

#Функционал запроса ввода из консоли повторяется, поэтому можно вынести его в метод
def persona
  gets.strip.capitalize
end

#Данные пользователя запишем в Хеш
hh = Hash.new
puts 'Введите ваше имя, фамилию и возраст.'

print  'Ваше имя: '
hh[:name] = persona

print 'Ваша фамилия: '
hh[:surname] = persona

print 'Ваш возраст: '
hh[:age] = persona.to_i

puts hh[:age] >= 18 ? "Привет #{hh[:name]} #{hh[:surname]}. Самое время заняться делом!" :
  "Привет #{hh[:name]} #{hh[:surname]}. Тебе меньше 18, но учиться программировать никогда не рано."

# Выведем получившийся Хеш с использованием метода p в который встроен puts и inspect
p hh
