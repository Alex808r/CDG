=begin
Написать скрипт, который будет выводить массив покемонов
- Спросить сколько добавить покемонов
- указанное на предыдущем этапе число спросить имя и цвет каждого покемона
- выводить в консоль массив содержащий хеши покемонов в формате
[{name: 'Pikachu', color: 'Yellow'}]
=end

# Вариант 2 с использованием метода

#Создаем пустой массив куда будем добавлять Хеши покемонов
@pokemons = Array.new

#Метод запрашивает количестов для добавления
def amount
  print 'Сколько добавить покемонов: '
  @amount = gets.to_i
end

def add_pokemons(pokemons)
  amount
  #Открвываем основной цикл добавления покемонов
  @amount.times do
    print 'Введите имя покемона: '
    name = gets.strip.capitalize
    print 'Введите цвет покемона: '
    color = gets.strip.capitalize
    @pokemons.push({name: name, color: color})
  end
  #Выводим получившийся массив в формате задания
  p @pokemons
end

add_pokemons(@pokemons)