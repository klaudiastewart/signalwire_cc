class Tag < ApplicationRecord
  belongs_to :ticket

  def self.unique_tags(tags)
    if tags
      downcase_tags = []
      tags.each do |tag|
          downcase_tags << tag.downcase
      end

      downcase_tags.uniq
    end
  end

  def self.get_count(ticket, unique_tags)
    if unique_tags
      unique_tags.map do |name|
        tag_instance = Tag.find_by(tag_name: name)
        if tag_instance
          byebug
          counter = tag_instance.count
          tag_instance.update(count: counter + 1)
        else
          ticket.tags.create(tag_name: name, count: 1)
        end
      end
    end
    Tag.order(count: :desc).first
  end
end
