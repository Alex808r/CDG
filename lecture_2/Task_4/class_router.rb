=begin
include подмешивает методы модуля на уровне экземпляра класса.
extend подмешивает методы модуля на уровне класса.
Для модуля Resource используется extend потому, что метод модуля необходимо добавить на уровне класса,
Вызов метода,добавленного из модуля на уровне класса, то есть на
PostsController и CommentsController, происходит в классе
Router:
 PostsController.connection(@routes['posts']) if choise == '1'
 CommentsController.connection(@routes['comments']) if choise == '2'

Работа класса Router
При создании экземпляра класса Router метод конструктор initialize создает пустой хеш и записывает этот хеш
в переменнюу @routes.
Метод init начинается с параметров, которые будут переданы в метод resources.
Перый параметр используется для создания экземпляра класса PostsController или CommentsController, а второй параметр
используется в качестве ключа к хешу, значениями которого являются пары маршрут => вызов соотвествующего метода в
соответствующем контроллере. Выбор метода зависит от резульатат работы цикла loop в module Resource.
Выбор метода из хеша происходит в строке action.nil? ? routes[verb].call : routes[verb][action].call
=end