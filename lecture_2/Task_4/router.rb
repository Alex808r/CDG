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
    puts @posts[post_index].nil? ? "Пост с индексом #{post_index} отсутствует" :
      "Пост c индексом #{post_index}: #{@posts[post_index]}"
  end

  def create
    puts 'Для создания поста введите следующие данные: '
    print 'Введите имя: '
    @author = gets.chomp.capitalize

    print 'Введите заголовок: '
    @title = gets.strip.capitalize

    print 'Введите текст: '
    @text = gets.strip.capitalize
    @posts.push({author: @author, title: @title, text: @text})
    puts 'created'
  end

  def update
    print 'Для обновления поста введите его индекс: '
    post_index = gets.to_i
    if @posts[post_index].nil?
      puts 'Пост с таким индексом отсутствует'
    else
      puts "Выбранный пост #{@posts[post_index]}"
      print 'Введите новый текст поста: '
      @text = gets.strip.capitalize
      @posts[post_index][:text] = @text
      puts "Текст поста после изменения: #{@posts[post_index]}"
      puts 'updated'
    end
  end

  def destroy
    print 'Для удаления поста введите его индекс: '
    post_index = gets.to_i
    if @posts[post_index].nil?
      puts 'Пост с таким индексом отсутствует.'
    else
      @posts.delete_at(post_index)
      puts "Пост с индексом #{post_index} удален."
      puts 'destroed'
    end
  end
end


class Router
  def initialize
    @routes = {}
  end

  def init
    resources(PostsController, 'posts')

    loop do
      print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
      choise = gets.chomp

      PostsController.connection(@routes['posts']) if choise == '1'
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
