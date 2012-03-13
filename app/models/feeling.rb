class Feeling < Post
  validates_length_of :photos, minimum: 1
end
