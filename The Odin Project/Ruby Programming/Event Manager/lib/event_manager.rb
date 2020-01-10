require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'date'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
  end
end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir("output") unless Dir.exists?("output")

  filename = "output/thanks_#{id}.html"

  File.open(filename,'w') do |file|
    file.puts form_letter
  end
end

def clean_phone_number(number)
    #reset bad numbers to '0000000000'
    str = number.to_s
    if str.length < 10 || str.length > 11
        return '0000000000'
    elsif str.length == 10
        return str
    else
        if str[0] == '1'
            return str[1..-1]
        else
            return '0000000000'
        end
    end
end
def clean_dates(d)
    arr = d.split(' ')
    date, time = arr[0].split('/'), arr[1].split(':')
    clean_date, clean_time = [], []
    date.each do |day|
        clean_date << '0' + day if day.length != 2
        clean_date << day if day.length == 2
    end
    time.each do |sec|
        clean_time << '0' + sec if sec.length != 2
        clean_time << sec if sec.length == 2
    end
    clean_date[0], clean_date[1] = clean_date[1], clean_date[0]
    return clean_date.join('/') + ' ' + clean_time.join(':')
end
def clean_day(date)
    return date.strftime("%d %m %Y").split(' ').map{|ele| ele.to_i}
end
puts "EventManager initialized."

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter
registration_times = []
registration_days = []

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])

  phone_number = clean_phone_number(row[:homephone].gsub(/\D/, ''))

  clean_date = DateTime.parse(clean_dates(row[:regdate]))
  time = clean_date.strftime('%H')
  registration_times << time

  clean_day = clean_day(clean_date)
  day = Date.new(clean_day[2], clean_day[1], clean_day[0])
  registration_days << day.wday

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id,form_letter)
end

def time_target(registration_times)
    time_count = Hash.new(0)
    registration_times.each do |time|
        time_count[time] += 1
    end
    print "Hours of the day the most people registered: "
    time_count.each { |k, v| print "#{k}, " if v == time_count.values.max }
    puts ""
end

def day_target(registration_days)
    day_count = Hash.new(0)
    registration_days.each do |day|
        day_count[day] += 1
    end
    print "Day of the week the most people registered on: "
    w_day = day_count.key(day_count.values.max)
    case w_day
    when 0
        day = "Sunday"
    when 1
        day = "Monday"
    when 2
        day = "Tuesday"
    when 3
        day = "Wednesday"
    when 4
        day = "Thursday"
    when 5
        day = "Friday"   
    when 6
        day = "Saturday"
    else
        "error!"
    end 
    print day
    puts ""
end

time_target(registration_times)
day_target(registration_days)