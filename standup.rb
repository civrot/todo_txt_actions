#!/usr/bin/env ruby

require 'date'

#read DONE file
done = File.read(ENV['DONE_FILE'])
done = done.split($/)
done.reverse!


today = Date.today
todays_completed = []

# ==============================
#    generate YESTERDAY's List
# ==============================

#define 'yesterday' as the last date on the done file that is not 'today'
i = 0
begin
    data = /x\s(?<date>\d{4}-\d{2}-\d{2})\s(?<task>.*)/.match(done[i]);
    yesterday  = Date.strptime(data[:date], '%Y-%m-%d')
    i += 1
end until today != yesterday

puts "\n\n========================================"
puts " Yesterday: #{yesterday}"
puts "========================================"

#dump out the list
done.each { |item|
    data =  /x\s(?<date>\d{4}-\d{2}-\d{2})\s(?<task>.*)/.match(item)
    task_date = Date.strptime(data[:date], '%Y-%m-%d')
    #puts task_date
    if task_date == yesterday 
        puts "+ #{data[:task]}"
    elsif task_date == today
	todays_completed.push(data[:task])       
    end
}


#read TODO file
todo = File.read(ENV['TODO_FILE'])
todo = todo.split($/)
# ==============================
#    generate TODAY's List
# ==============================

puts "\n\n========================================"
puts " Today: #{Date.today}"
puts "========================================"

#dumpe TODAY's COMPELTED
todays_completed.each { |task|
    puts "+ #{task}"
}

#dump  TODAY's List
todo.each { |task| 
    puts "- #{task}"
}
#generate IMPEDIMENT's List
