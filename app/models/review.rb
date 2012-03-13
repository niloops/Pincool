class Review < Post
  field :title, type: String
  field :evas, type: Array

  validates_presence_of :title
  validates_presence_of :evas
  validates_length_of :evas, is: 3

  validate do |review|
    review.evas.each do |eva|
      unless (1..10).include? eva
        errors.add(:evas,
                 "evas isn't an array with 3 numbers in [1..10]")
      end
    end
  end

end
