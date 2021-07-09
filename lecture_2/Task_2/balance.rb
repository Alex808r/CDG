=begin
Напишите программу, которая начинается с чтения банковского баланса клента из файла
с именем balance.txt. Этот файл содержит одну строку со стартовым балансом клиента. Если файл не существует, исплользуйте
стартовый баланс 100.0, который должен быть константой.

После этого программа повторно предложит клиенту внести деньги, вывести деньги, проверить
баланс или выйти, используя буквы D(deposit) W(withdraw) B(balance) Q(quit)/.
Программа должна принимать на вход значения в верхнем или нижнем регистре
=end

current_path = File.dirname(__FILE__)

file_path = current_path + './data/balance.txt'

if File.exist?(file_path)
  f = File.open(file_path,'r')
  BALANCE = f.read.to_i
  #f.close
  else
  BALANCE = 100.0
  puts 'Файл "balance.txt" не найдет, используется дефолтный баланс: 100.0'
end

loop do
  print "Выберите желаемое действие с вашим балансом - D(положить) W(снять) B(баланс) Q(выход): "
  choice = gets.strip.upcase
    case choice
    when 'Q' then exit
    when 'D' then
      print "Введите сумму для пополнения: "
      BALANCE += gets.to_i
    when 'W' then
      print "Введите сумму для снятия: "
      BALANCE -= gets.to_i
    when 'B' then puts "Ваш баланс #{BALANCE}"
    end
end

