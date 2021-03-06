#!/usr/bin/ruby

class MDP
  def initialize(filename, absError, qIterations)
    @filename = filename
    @viIdentifier = "_vi"
    @qlearnIdentifier = "_qlearn"
    
    @absError = absError
    @qIterations = qIterations
    @epsilon = 0
    @usefulnessfilecols = 1
    @iteration = 1
    
    @arrows = { left: '<', right: '>', up: '^', down: 'v' }
    
    splitLines = IO.readlines(filename)
    
    initHeader(splitLines)
    initBoard(splitLines)
    initSpecialCosts(splitLines)
    
    printHeader()    
    printFields()
    printCosts()
  end
  
  def printHeader()
    puts
    puts 'Input - Header:'
    puts 'a=' + @a.to_s + ', b=' + @b.to_s
    puts 'reward=' + @reward.to_s + ' discount=' + @discount.to_s + ' eps=' + @epsilon.to_s
  end

  def printFields()
    puts
    puts 'Input - Fields:'
    (@m-1).downto(0) do |j|
      0.upto(@n-1) do |i|
        print @fields[j][i].to_s + " "
      end
      puts
    end
  end
  
  def printCosts()
    puts
    puts 'Input - Costs:'
    (@m-1).downto(0) do |j|
      0.upto(@n-1) do |i|
        print @rewards[j][i].to_s + " "
      end
      puts
    end
  end
  
  def initHeader(splitLines)    
    header = splitLines[0].scan(costParseRegex())
    @n, @m = header[0].to_i, header[1].to_i
    @a, @b = header[2].to_f, header[3].to_f 
    @reward = header[4].to_f
    @discount = header[5].to_f
    @epsilon = header[6].to_f
    
    @startingX = 0
    @startingY = 0

    @rewards = Array.new(@m) { Array.new(@n, @reward) }
    @fields = Array.new(@m) { Array.new(@n) }
  end
    
  def initBoard(splitLines)
    board = splitLines[1..@m]
    j = @m - 1
    board.each do |line|
      lineItems = line.scan /[OSBFG]/
      
      i = 0
      lineItems.each do |field|
        @fields[j][i] = field
        
        if isStarting(i, j)
          @startingX = i
          @startingY = j
        end
        
        i += 1
      end
      j -= 1
    end
  end
  
  def initSpecialCosts(splitLines)
    specialCosts = splitLines.drop(@m + 1)
    specialCosts.each do |line|
      x, y, cost = line.scan costParseRegex()
      i = x.to_i - 1
      j = y.to_i - 1
      @rewards[j][i] = cost.to_f
    end
  end

  def absoluteDifferenceOverLimit(a, b)
    return (a - b).abs > @absError
  end

  def isForbidden(x,y)
    x < 0 || x >= @n ? true :
    y < 0 || y >= @m ? true :
    @fields[y][x] == 'F' ? true :
    false
  end
  
  def isTerminal(x,y)
    @fields[y][x] == 'G' ? true : false
  end
  
  def isStarting(x,y)
    @fields[y][x] == 'S' ? true : false
  end
  
  def isDefault(x,y)
    @fields[y][x] == 'O' ? true : false
  end
  
  def moveValue(primaryDirection, secondaryOne, secondaryTwo)
    @a * primaryDirection + @b * (secondaryOne + secondaryTwo)
  end

  def bestMove(x,y)
    current = @usefulness[y][x]
    
    l = isForbidden(x-1, y) ? current : @usefulness[y][x-1]
    r = isForbidden(x+1, y) ? current : @usefulness[y][x+1]
    u = isForbidden(x, y+1) ? current : @usefulness[y+1][x]
    d = isForbidden(x, y-1) ? current : @usefulness[y-1][x]
    
    lValue = moveValue(l, d, u)
    rValue = moveValue(r, d, u)
    uValue = moveValue(u, l, r)
    dValue = moveValue(d, l, r)
    
    maxValue = [lValue, rValue, uValue, dValue].max  
    direction = { lValue => :left, rValue => :right, uValue => :up, dValue => :down }[maxValue]

    return maxValue, @arrows[direction]
  end
  
  def solveVIAlgorithm
    initLogFile(@viIdentifier)
    
    @usefulness = Array.new(@m) { Array.new(@n, 0) }
    @iteration = 1  
    changed = true
    
    while changed
      changed = false
      newUsefulness = Array.new(@m) { Array.new(@n, 0) }
      
      0.upto(@n-1) do |i|
        0.upto(@m-1) do |j|
          if isTerminal(i, j) 
            newUsefulness[j][i] = @rewards[j][i]
          elsif !isForbidden(i, j)
            new = @rewards[j][i] + @discount * bestMove(i,j).first
            if absoluteDifferenceOverLimit(new, @usefulness[j][i])
              changed = true
            end
            newUsefulness[j][i] = new
          end
        end
      end

      @usefulness = newUsefulness
      logVIUsefulness(@iteration)
      @iteration += 1
    end
  end

  def newCoordinates(x, y, a)
    newX = { 0 => x-1, 1 => x+1, 2 => x, 3 => x }[a]
    newY = { 0 => y, 1 => y, 2 => y+1, 3 => y-1 }[a]
    
    isForbidden(newX, newY) ?  (result = x,y) : (result = newX, newY)
  end
    
  def printableDirection(a)
    hash = { 0 => :left, 1 => :right, 2 => :up, 3 => :down }
    @arrows[hash[a]]
  end
  
  def bestQDirection(x, y)
    maxUsefulness = @qualities[y][x].max
    @qualities[y][x].index(maxUsefulness)
  end

  def learningRate(x, y, direction)
    Float(1) / (@frequencies[y][x][direction] + 1)
  end
  
  def learnedValue(x, y, nextX, nextY, direction)
    @rewards[y][x] + @discount * @qualities[nextY][nextX].max - @qualities[y][x][direction]
  end
  
  def newFactor(x, y, nextX, nextY, direction)
    learningRate(x, y, direction) * learnedValue(x, y, nextX, nextY, direction)
  end
  
  def solveQLearnAlgorithm
    initLogFile(@qlearnIdentifier)
  
    @qualities = Array.new(@m) { Array.new(@n) { Array.new(4, 0) } }
    @frequencies = Array.new(@m) { Array.new(@n) { Array.new(4, 0) } }
    
    1.upto(@qIterations) do |i|
      x = @startingX
      y = @startingY
      @iteration = 1

      begin
        if @epsilon * 100 <= rand(100)
          direction = rand(4)
        else
          direction = bestQDirection(x, y)
        end
      
        nextX, nextY = newCoordinates(x, y, direction)
      
        @qualities[y][x][direction] += newFactor(x, y, nextX, nextY, direction)
        @frequencies[y][x][direction] += 1

        x = nextX
        y = nextY
        @iteration += 1
      end while !isTerminal(nextX, nextY)
    
      0.upto(3) { |i|  @qualities[y][x][i] = @rewards[y][x] }
      
      logQLearnUsefulness(i)
    end
  end
  
  def usefulnessPolicy()
    policy = Array.new(@m) { Array.new(@n, 0) }
    
    0.upto(@n-1) do |i|
      0.upto(@m-1) do |j|
        if isForbidden(i, j) || isTerminal(i, j)
          policy[j][i] = @fields[j][i]
        else
          policy[j][i] = bestMove(i,j).fetch(1)
        end
      end
    end
    
    return policy
  end

  def logVIUsefulness(iteration)
    usefulnessLogFile = File.new(@filename + @viIdentifier + ".util", "a")
    usefulnessLogFile.syswrite(iteration.to_s)
    
    (@m-1).downto(0) do |j|
      0.upto(@n-1) do |i|
        if isDefault(i, j) || isStarting(i, j)
          usefulnessLogFile.syswrite("\t" + @usefulness[j][i].round(3).to_s)
        end
      end
    end
    
    usefulnessLogFile.syswrite("\n")
    usefulnessLogFile.close
  end

  def logQLearnUsefulness(iteration)
    usefulnessLogFile = File.new(@filename + @qlearnIdentifier + ".util", "a")
    usefulnessLogFile.syswrite(iteration.to_s)
    
    (@m-1).downto(0) do |j|
      0.upto(@n-1) do |i|
        if isDefault(i, j) || isStarting(i, j)
          usefulnessLogFile.syswrite("\t" + @qualities[j][i].max.round(3).to_s)
        end
      end
    end
    
    usefulnessLogFile.syswrite("\n")
    usefulnessLogFile.close
  end
  
  def storeGraph(filename, ymax, index)
    `gnuplot -e "fname='#{filename}.util'; xrg=#{index-1}; \
      min=#{@rewards.flatten.min}; \
      max=#{ymax}; \
      cols=#{@usefulnessfilecols}" \
      src/plot.gnuplot`
  end
  
  def storeQLearnGraph()
    ymax = @qualities.flatten.flatten.max
    storeGraph(@filename + @qlearnIdentifier, ymax, @qIterations)
  end
  
  def storeVIGraph()
    ymax = @usefulness.flatten.max
    storeGraph(@filename + @viIdentifier, ymax, @iteration)
  end
  
  def storeLog()
    policyFile = File.new(@filename + ".pol", "w")
    policy = usefulnessPolicy()
    
    storePolicyLog(policyFile, policy)
    storeUsefulnessLog(policyFile, policy)
    
    policyFile.close
  end

  def storePolicyLog(policyFile, policy)  
    (@m-1).downto(0) do |j|
      0.upto(@n-1) do |i|
        policyFile.syswrite(' ' + policy[j][i].to_s)
      end
      policyFile.syswrite("\n")
    end
  end
  
  def storeUsefulnessLog(policyFile, policy)
    (@m-1).downto(0) do |j|
      0.upto(@n-1) do |i|
        policyFile.syswrite(' ' + @usefulness[j][i].round(3).to_s)
      end
      policyFile.syswrite("\n")
    end
  end
  
  def initLogFile(suffix)
    usefulnessFile = File.new(@filename + suffix + ".util", "w")
    usefulnessFile.syswrite('i')
    
    @usefulnessfilecols = 1
    (@m-1).downto(0) do |j|
      0.upto(@n-1) do |i|
        if isDefault(i, j) || isStarting(i, j)
          usefulnessFile.syswrite("\t[#{i},#{j}]")
          @usefulnessfilecols += 1
        end
      end
    end
    
    usefulnessFile.syswrite("\n")
    usefulnessFile.close 
  end
  
  def printVIDirections()
    puts
    puts "Output - ValueIteration directions:"
    policy = usefulnessPolicy()
    
    (@m-1).downto(0) do |j|
      0.upto(@n-1) do |i|
        if isForbidden(i, j) || isTerminal(i, j)
          print @fields[j][i]
        else
          print policy[j][i]
        end
      end
      puts
    end
  end
  
  def printVIUsefulness()
    puts
    puts "Output - ValueIteration usefulnesses:"
    (@m-1).downto(0) do |j|
      0.upto(@n-1) do |i|
        printf "%7.2f ", @usefulness[j][i]
      end
      puts
    end
  end
    
  def printQLearnDirections()
    puts
    puts 'Output - QLearning directions:'
    (@m-1).downto(0) do |j|
      0.upto(@n-1) do |i|
        if isForbidden(i, j) || isTerminal(i, j)
          print @fields[j][i]
        elsif
          print printableDirection(bestQDirection(i, j))
        end
      end
      puts
    end
  end
    
  def printQLearnUsefulness()
    puts
    puts 'Output - QLearning qualities:'
    (@m-1).downto(0) do |j|
      0.upto(@n-1) do |i|
        printf "%7.2f ", @qualities[j][i].max
      end
      puts
    end
  end
  
end

