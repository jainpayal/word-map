class WordMap

  def initialize
    @dictionary = []
    @letters = {"2" => ["a", "b", "c"],"3" => ["d", "e", "f"],"4" => ["g", "h", "i"],"5" => ["j", "k", "l"],"6" => ["m", "n", "o"],"7" => ["p", "q", "r", "s"],"8" => ["t", "u", "v"],"9" => ["w", "x", "y", "z"]}
  end

  def map_words(numbers)
    #return if number not valid - number should contains 10 digit and numeric character.
    return [] if numbers.nil? || numbers.length != 10 || numbers.split('').select{|a|(a.to_i == 0 || a.to_i == 1)}.length > 0

    # Read dictionary file and collect all the words in array

    file_path = "../public/dictionary.txt"
    File.foreach( file_path ) do |letter|
      @dictionary << letter.chop.to_s.downcase
    end

    # convert digit to letters's array format e.g. [["a", "b", "c"], ["a", "b", "c"], ["t", "u", "v"], ["a", "b", "c"], ["m", "n", "o"], ["m", "n", "o"], ["t", "u", "v"], ["m", "n", "o"], ["t", "u", "v"], ["p", "q", "r", "s"]]
    keys = numbers.chars.map{|digit|@letters[digit]}

    results = {}
    total_number = keys.length-1 # total numbers i.e. 10
    (1..total_number).each do |n|

      arr_1 = keys[0..n]
      arr_2 = keys[n + 1..total_number]

      next if arr_2.length < 1 # to check nil or 0 length array

      comb_1 =  combination(arr_1) # Get product of arrays
      comb_2 = combination(arr_2)
      # collect the result of Array's combination
      results[n] = [(comb_1 & @dictionary), (comb_2 & @dictionary)] # get common values from arrays
    end

    combo_result = []
    results.each do |key, combinataions|
      next if combinataions.first.nil? || combinataions.last.nil?
      combinataions.first.product(combinataions.last).each do |combo_words|
        # collect the result of Word's combination
        combo_result << combo_words
      end
    end

    # for all numbers
    combo_result << (keys.shift.product(*keys).map(&:join) & @dictionary).join(", ") # match with all character
    combo_result
  end

  def combination(array)
    array.shift.product(*array).map(&:join)
  end
end

obj = WordMap.new()
result = obj.map_words("2282668687")
print result
