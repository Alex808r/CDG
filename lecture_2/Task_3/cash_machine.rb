#Сохраним в переменнюу путь к самой программе чтобы гарантировать в дальнейшем правильный путь к файлу balance.txt
current_path = File.dirname(__FILE__)

# Записываем путь к файлу в переменную / теперь можем запускать программу вне зависимости от нашего местоположения в консоли
file_path = current_path + './data/balance.txt'

#Проводим проверку наличия файла, если файл есть, то пристваиваем переменной значение из файла если нет, то присваиваем
# дефолтное значение 100.0
if File.exist?(file_path)
  f = File.open(file_path,'a+')
  BALANCE = f.read.to_f
else
  BALANCE = 100.0
  puts 'Файл "balance.txt" не найдет, используется дефолтный баланс: 100.0'
end

class CashMachine

  def self.init
    CashMachine.new
  end

  attr_accessor :money

  def initialize
    @money
  end

  def add_money(sum = 0)
    print 'Введите сумму пополнения: '
    sum = gets.to_f
    puts sum > 0 ? "Ваш баланс пополнен на #{sum} и составляет #{@money += sum}" : "Сумма не может быть меньше 0"
  end

  def withdraw(sum = 0)
    print 'Введите сумму для снятия: '
    sum = gets.to_f
    puts "Сумма не может быть меньше 0" if sum < 0
    puts sum > @money ? "Сумма не может быть больше текущего баланса" : "Ваш баланс #{@money -= sum}"
  end

  def show
    puts "Ваш баланс #{@money}"
  end

  def exit
    puts "Завершение программы. Баланс #{@money}"
  end

end

#Программа начинается с метода класса - инициализируем объект
deposit = CashMachine.init

# Переменная money доступна благодяра attr_accessor. Присваиваем одно из двух возможных значений в зависимости от наличия
# или отсутствия файла 500 или 100 соответственно.
deposit.money = BALANCE

# Основной цикл программы
loop do
  print 'Выберите желаемое действие с вашим балансом - D(положить), W(снять), B(показать), Q(выйти): '
  choice = gets.strip.upcase
  case choice
  when 'D' then deposit.add_money
  when 'W' then deposit.withdraw
  when 'B' then deposit.show
  when 'Q' then break deposit.exit
  end
end

f.puts(deposit.money)
f.close
