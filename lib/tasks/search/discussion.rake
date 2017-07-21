namespace :search do
  desc 'Delete discussion index'
  task delete_index: :environment do
    begin
    rescue Exception => e
      puts "Delete index failed : #{e.inspect}"
    end
  end

  desc 'Create discussion index'
  task create_index: :environment do
    Discussion.reindex
  end
end
