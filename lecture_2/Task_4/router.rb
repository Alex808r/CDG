module Resource
  def connection(routes)
    if routes.nil?
      puts "No route matches for #{self}"
      return
    end

    loop do
      print 'Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: '
      verb = gets.chomp.upcase
      break if verb == 'q'

      action = nil

      if verb == 'GET'
        print 'Choose action (index/show) / q to exit: '
        action = gets.chomp
        break if action == 'q'
      end


      action.nil? ? routes[verb].call : routes[verb][action].call
    end
  end
end

class PostsController
  extend Resource

  def initialize
    @posts = []
  end

  def index
    puts @posts.empty? ? 'Список постов пуст.' : 'Список всех постов: '
    @posts.each_with_index{ |item,index| puts "Индекс: #{index}, Пост: #{item}"}
  end

  def show
    print 'Для отображения поста введите его индекс: '
    post_index = gets.to_i
    puts @posts[post_index].nil? ? "Пост с индексом #{post_index} отсутствует." :
           "Пост c индексом #{post_index}: #{@posts[post_index]}"
  end

  def create
    print 'Для создания поста введите Y: '
    answer = gets.strip.downcase
    if answer == 'y'
      print 'Введите автора: '
      @author = gets.strip.capitalize
      print 'Введите заголовок: '

      @title = gets.strip.capitalize
      print 'Введите текст: '

      @text = gets.strip.capitalize
      puts "Пост создан: #{@posts.push({author: @author, title: @title, text: @text, comments: [] })}"
    else
      puts 'Вы отказались от создания поста.'
    end

    print 'Для создания комментария введите Y: '
    answer = gets.strip.downcase
    if answer == 'y' && @posts.any?
      print 'Введите индекс поста, к которому нужно добавить комментарий: '
      post_index = gets.to_i
      print 'Введите текст комментария: '
      comment = gets.strip.capitalize
      @posts[post_index][:comments] << comment
      puts "Комментарий добавлен: #{@posts[post_index][:comments]}"
    else
      puts 'Вы отказались от добавления комментария или не можете добавить его, так как нет ни одного поста.'
    end
  end

  def update
    print 'Для обновления поста введите его индекс: '
    post_index = gets.to_i
    if @posts[post_index].nil?
      puts "Пост с индексом #{post_index} отсутствует."
    else
      puts "Вы выбрали пост: #{@posts[post_index]}"
      print 'Введите новый текст поста: '
      @text = gets.strip.capitalize
      @posts[post_index][:text] = @text
      puts "Текст поста после изменения: #{@posts[post_index]}"

      print 'Для изменения комментария нажмине Y: '
      answer = gets.strip.downcase
      if answer == 'y'
        print 'Введите индекс поста: '
        post_index = gets.to_i
        print 'Ввведите индекс комметария: '
        comment_index = gets.to_i
        print 'Введите новый комментарий: '
        comment = gets.strip.capitalize
        @posts[post_index][:comments][comment_index] = comment
        puts "Комментарий изменен #{@posts[post_index][:comments]}"
      else
        puts 'Вы отказались от изменения комментария'
      end
    end
  end

  def destroy
    print 'Для удаления поста введите его индекс: '
    post_index = gets.to_i
    if @posts[post_index].nil?
      puts "Пост c индексом #{post_index} отсутствует."
    else
      @posts.delete_at(post_index)
      puts "Пост с индексом #{post_index} удален."
    end
  end
end

class CommentsController
  extend Resource

  def initialize
    @posts = [{author: "Автор 0", title: "Заголовок 0", text: "Текст 0", comments: ['Комментарий 0', 'Комментарий 00' ]},
              {author: "Автор 1", title: "Заголовок 1", text: "Текст 1", comments: ['Комментарий 1', 'Комментарий 11' ]},
              {author: "Автор 2", title: "Заголовок 2", text: "Текст 2", comments: ['Комментарий 2', 'Комментарий 22' ]}
    ]
  end

  def index
    puts @posts.empty? ? 'Список постов пуст.' : 'Список всех постов c комментариями: '
    @posts.each_with_index{ |item,index| puts "Индекс: #{index}, Пост: #{item}"}
  end

  def show
    print 'Для получения списка комментариев введите индекс поста: '
    post_index = gets.to_i
    puts @posts[post_index].nil? ? "Пост с индексом '#{post_index}' не найден" :
           "Комментарии к посту c индексом #{post_index} : #{@posts[post_index][:comments]}"
  end

  def create
    print 'Для добавления комментария введите индекс поста: '
    post_index = gets.to_i
    if @posts[post_index].nil?
      puts "Пост с индексом #{post_index} не найден"
    else
      puts 'Введите текст комментария: '
      comment = gets.strip.capitalize
      @posts[post_index][:comments].push(comment)
      puts "Список комментариев к посту по индексу #{post_index} : #{@posts[post_index][:comments]}"
    end
  end

  def update
    print 'Для обновления комментария введите индекс поста: '
    post_index = gets.to_i
    if @posts[post_index].nil?
      puts "Пост с индексом #{post_index} не найден"
    else
      puts "Комментарии к посту с индексом #{post_index}: "
      @posts[post_index][:comments].each_with_index {|item,index| puts "Индекс: #{index} Текст комментария: #{item}"}
      print 'Для обновления комментария введите индекс комментария: '
      comment_index = gets.to_i
      print 'Для обновления комментария введите новый текст комментария: '
      comment = gets.strip.capitalize
      @posts[post_index][:comments][comment_index] = comment
      puts "Обновленный комментарий #{@posts[post_index][:comments]}"
    end
  end

  def destroy
    print 'Для удаления комментария введите индекс поста: '
    post_index = gets.to_i
    if @posts[post_index].nil?
      puts "Пост с индексом #{post_index} не найден"
    else
      puts "Комментарии к посту с индексом #{post_index}: "
      @posts[post_index][:comments].each_with_index {|item,index| puts "Индекс: #{index} Текст комментария: #{item}"}
      print 'Для удаления комментария введите индекс комментария: '
      comment_index = gets.to_i
      @posts[post_index][:comments].delete_at(comment_index)
      puts "Обноленный список комментариев #{@posts[post_index][:comments]}"
    end
  end

end

class Router
  def initialize
    @routes = {}
  end

  def init
    resources(PostsController, 'posts')
    resources(CommentsController, 'comments')

    loop do
      print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
      choise = gets.downcase.chomp

      PostsController.connection(@routes['posts']) if choise == '1'

      CommentsController.connection(@routes['comments']) if choise == '2'
      break if choise == 'q'

    end

    puts 'Good bye!'
  end

  def resources(klass, keyword)
    controller = klass.new
    @routes[keyword] = {
      'GET' => {
        'index' => controller.method(:index),
        'show' => controller.method(:show)
      },
      'POST' => controller.method(:create),
      'PUT' => controller.method(:update),
      'DELETE' => controller.method(:destroy)
    }
  end
end

router = Router.new

router.init