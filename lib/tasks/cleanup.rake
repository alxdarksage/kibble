namespace :alx do
    desc 'Fix all the parentheses'
    task :cleanup => :environment do
        Item.find(:all).each do |item|
            item.name = item.name.gsub("(","{")
            item.name = item.name.gsub(")","}")
            item.save
        end
    end
end