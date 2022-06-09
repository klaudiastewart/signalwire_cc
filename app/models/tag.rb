class Tag < ApplicationRecord
  def self.unique_tags(tags)
    downcase_tags = []
    tags.each do |tag|
        downcase_tags << tag.downcase
    end

    downcase_tags.uniq
  end

  def self.get_count(unique_tags)
    unique_tags.map do |name|
      tag_instance = Tag.find_by(tag_name: name)

      if tag_instance
        counter = tag_instance.count
        tag_instance.update(count: counter + 1)
      else
        Tag.create(tag_name: name, count: 1)
      end
    end
    Tag.order(count: :desc).first
  end
end
