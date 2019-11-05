class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes
  accepts_nested_attributes_for :notes, :reject_if => proc { |attrs| attrs[:content].blank? }


  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    self.artist ? self.artist.name : nil
  end

  def genre_id=(id)
    self.genre = Genre.find(id)
  end

  def genre_id
    self.genre ? self.genre.id : nil
  end

  def note_contents=(note_contents)
    note_contents.each do |note|
      note = Note.find_or_create_by(content: note)
      self.notes << note
    end
  end


end
