require 'sqlite3'
require 'singleton'

class QuestionsDB < SQLite3::Database
  include Singleton
  
  def initialize
    super('questions.db')
    # self.type_translation = true
    self.results_as_hash = true
  end
end

class User
  attr_reader :id
  attr_accessor :fname, :lname
  
  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end
  
  def self.find_by_name(fname, lname)
    data = QuestionsDB.instance.execute("SELECT * FROM users WHERE fname = #{fname} AND lname = #{lname}")
    people = []
    data.each do |datum|
      person = User.new(datum)
      people << person
    end 
    people 
  end
  
  def self.find_by_id(id)
    user = QuestionsDB.instance.execute(<<-SQL, id)
      SELECT * FROM users
      WHERE id = ?
      SQL
      User.new(user.first)
    end

end
  # why this is not working ^
  # def self.find_by_id(id)
  #   data = QuestionsDB.instance.execute("SELECT * FROM users WHERE id = #{id}").first
  #   User.new(data)
  # end
  # why is this returning an array of data? and not one answer when we know it will be one answer

# end

class Question 
  attr_reader :id 
  attr_accessor :body, :title, :asso_author
  
  def self.find_by_question(id)
    data = QuestionDB.instance.execute("SELECT * FROM questions WHERE id = #{id}").first
    Question.new(data)
  end 
  
  
  def initialize(options)
    @id = options['id']
    @title = options['title']
    @asso_author = options['asso_author']
    @body = options['body']
  end 
  
  

end 
