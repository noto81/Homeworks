require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :id, :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id, self.id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end

  def find_by_title(title)
    play = PlayDBConnection.instance.execute(<<-SQL, title)
    SELECT
      *
    FROM
      plays
    WHERE
      title = ?
  SQL
  return nil unless play.length > 0

  Play.new(play.first) # play is stored in an array!

  end
  
  def find_by_playwright(name) 
    #returns all plays written by playwright
    playwright = Playwright.find_by_name(name)
    raise "#{name} not found in DB" unless playwright

    plays = PlayDBConnection.instance.execute(<<-SQL, playwright.id)
      SELECT
        *
      FROM
        plays
      WHERE
        playwright_id = ?
    SQL

    plays.map { |play| Play.new(play) }

  end

end



class Playwright
  attr_accessor :id, :name, :birth_year

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM playwrights")
    data.map { |datum| Playwright.new(datum) }
  end

  def self.find_by_name(name)
    person = PlayDBConnection.instance.execute(<<-SQL, name)
      SELECT
        *
      FROM
        playwrights
      WHERE
        name = ?
    SQL
    return nil unless person.length > 0 # person is stored in an array!

    Playwright.new(person.first)
  end

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @birth_year = options['birth_year']
  end

  def insert
    raise "#{self} already in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year)
      INSERT INTO
      playwrights (name, birth_year)
      VALUES
        (?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end



  def create
    raise "#{self} already in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year)
      INSERT INTO
      playwrights (name, birth_year)
      VALUES
        (?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end



  def update
    raise "#{self} not in database" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year, self.id)
      UPDATE
        playwrights
      SET
        name = ?, birth_year = ?
      WHERE
        id = ?
    SQL
  end

  def get_plays
    raise "#{self} not in database" unless self.id
    plays = PlayDBConnection.instance.execute(<<-SQL, self.id)
      SELECT
        *
      FROM
        plays
      WHERE
        playwright_id = ?
    SQL
    plays.map { |play| Play.new(play) }
  end

end


# [22] pry(main)> a = Playwright.new("name" => "Antonio","birth_year" => 1981)  
# => #<Playwright:0x00007fffc2b5de60 @birth_year=1981, @id=nil, @name="Antonio">
# [23] pry(main)> a
# => #<Playwright:0x00007fffc2b5de60 @birth_year=1981, @id=nil, @name="Antonio">
# [24] pry(main)> Playwright.all
# => [#<Playwright:0x00007fffc2bd7eb8 @birth_year=1915, @id=1, @name="Arthur Miller">,
#  #<Playwright:0x00007fffc2bd7e18 @birth_year=1888, @id=2, @name="Eugene O'Neill">]
# [25] pry(main)> a.create
# => 3
# [26] pry(main)> Playwright.all
# => [#<Playwright:0x00007fffc2c526b8 @birth_year=1915, @id=1, @name="Arthur Miller">,
#  #<Playwright:0x00007fffc2c52618 @birth_year=1888, @id=2, @name="Eugene O'Neill">,
#  #<Playwright:0x00007fffc2c52578 @birth_year=1981, @id=3, @name="Antonio">]
# [27] pry(main)> a.birth_year = 1991
# => 1991
# [28] pry(main)> Playwright.all
# => [#<Playwright:0x00007fffc2cdc750 @birth_year=1915, @id=1, @name="Arthur Miller">,
#  #<Playwright:0x00007fffc2cdc6b0 @birth_year=1888, @id=2, @name="Eugene O'Neill">,
#  #<Playwright:0x00007fffc2cdc610 @birth_year=1981, @id=3, @name="Antonio">]
# [29] pry(main)> a.update
# => []
# [30] pry(main)> Playwright.all
# => [#<Playwright:0x00007fffc2d76328 @birth_year=1915, @id=1, @name="Arthur Miller">,
#  #<Playwright:0x00007fffc2d76288 @birth_year=1888, @id=2, @name="Eugene O'Neill">,
#  #<Playwright:0x00007fffc2d761e8 @birth_year=1991, @id=3, @name="Antonio">]
