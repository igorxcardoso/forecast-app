# https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/maximum-non-overlapping-intervals/problem

def maximizeNonOverlappingMeetings(meetings)
  
  # Ordenação dos intervalor pelo y
  meetings.sort_by! { |interval| interval[1] }

  count = 0
  last_end = -Float::INFINITY

  meetings.each do |start_time, end_time|
    
    puts "#{start_time} #{end_time}"

    # Verifica se start_time do intervalor é meior ou igual ao end_time do último inervalor 
    if start_time >= last_end
      count += 1
      last_end = end_time
    end
  end

  count
end


meetings = [[1, 2], [2, 3], [3, 4], [1, 3], [4, 7]]
puts maximizeNonOverlappingMeetings(meetings)