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

  after_create :add_evas_to_brand
  around_update :update_evas_to_brand
  after_destroy :destroy_evas_to_brand

  private

  def add_evas_to_brand
    brand.update_total_evas evas
  end

  def update_evas_to_brand
    evas_change = changes[:evas]
    yield
    if evas_change
      brand.update_total_evas(evas_change[0].map(&:-@))
      brand.update_total_evas(evas_change[1])
    end
  end

  def destroy_evas_to_brand
    brand.update_total_evas(evas.map(&:-@))
  end

end
