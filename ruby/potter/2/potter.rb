class Potter

  attr_reader :book_price, :discount

  def initialize
    @book_price = 8
    @discount = {
      0 => 1,
      1 => 1,
      2 => 0.95,
      3 => 0.9,
      4 => 0.8,
      5 => 0.75
    }
  end

  def price(books)
    groups = sort_book_groups(books)
    discount_groups = build_discount_groups(groups)
    calculate_total(discount_groups)
  end

  private

  def sort_book_groups(books)
    books.group_by{ |e| e }.map { |key, value| value }
  end

  def build_discount_groups(groups)
    discount_groups = Hash.new(0)
    for i in 1..highest_count_of_items(groups) do
      discount_groups[group_number(i)] = groups.collect(&:shift).compact
    end
    discount_groups
  end

  def highest_count_of_items(groups)
    max = 1
    groups.each do |group|
      if group.count > max
        max = group.count
      end
    end
    max
  end

  def group_number(key)
    "group_number_#{key}".to_sym
  end

  def calculate_total(discount_groups)
    total = 0
    discount_groups.each do |key, books|
      total += calculate_discount(books)
    end
    total
  end

  def calculate_discount(books)
    book_price * books.count * discount[books.count]
  end
end