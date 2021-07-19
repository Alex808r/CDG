=begin
Переписать банкомат из ЛЗ #4 на работу с веб сервером.
необходимо заменить ввод и вывод данных (по условию изначальной задачи)
на запросы вместо работы с консолью

GET/deposit?value= - Увеличение баланса
GET/withdraw?value - Уменьшение баланса
GET/balance - Отображение баланса
=end

require 'socket'
require 'rack'
require 'rack/utils'


#Сохраним в переменнюу путь к самой программе чтобы гарантировать в дальнейшем правильный путь к файлу balance.txt
current_path = File.dirname(__FILE__)
#
# # Записываем путь к файлу в переменную / теперь можем запускать программу вне зависимости от нашего местоположения в консоли
file_path = current_path + './data/balance.txt'

# Проводим проверку наличия файла, если файл есть, то пристваиваем переменной значение из файла если нет, то присваиваем
# дефолтное значение 100.0
if File.exist?(file_path)
  @f = File.open(file_path,'a+')
  BALANCE = @f.read.to_f
else
  BALANCE = 100.0
  #puts 'Файл "balance.txt" не найдет, используется дефолтный баланс: 100.0'
end

# Класс банкомат - выполняет операции со счетом.
class CashMachine

  attr_accessor :money

  def initialize
    @money
  end

  def self.init
    CashMachine.new
  end

  def show
    @money.to_s
  end

  def add_money(sum)
    #Пополнить баланс
    @money += sum.to_f
    self.show
  end

  def withdraw(sum)
    #Сумма для снятия
    @money -= sum.to_f
    self.show
  end

end

# Сервер для банкомата
class App

  attr_accessor :cashmachine

  def initialize
    @cashmachine = CashMachine.init # создаем объект
    @cashmachine.money = BALANCE    # присваиваем объекту значение money либо из файла, либо дефолтное 100.0
    super
  end

  def call(env)
    req = Rack::Request.new(env)
    case req.path
    when '/'
      [200, {'Content-Type' => 'text/html'}, [req.params['value']]]
    when '/balance'
      [200, {'Content-Type' => 'text/html'}, [@cashmachine.show]]
    when '/deposit'
      [200, {'Content-Type' => 'text/html'}, [@cashmachine.add_money(req.params['value'])]]
    when '/withdraw'
      [200, {'Content-Type' => 'text/html'}, [@cashmachine.withdraw(req.params['value'])]]
    else
      [404, {'Content-Type' => 'text/html'}, ["Not found"]]
    end
  end
end

app = App.new
run app
