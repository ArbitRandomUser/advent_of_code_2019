lines = readlines("input")

callout_numbers = split(lines[1],",")
boards = split.([line for line in lines[2:end] if line!=""])
boards2 = deepcopy(boards)

function callout(number::AbstractString , boardrows)
  for row in boardrows #boards is concatenead all boards
    for (i,c) in enumerate(row)
      if c==number
	row[i]="X"
      end
    end
  end
end

function checkbingo(i,boardrows)
  prevrow = boardrows[5*i-4] 
  columns = BitVector([1,1,1,1,1])
  for row in boardrows[5i-4:5i]
    columns .= columns .& (row.==repeat(["X",],5))
    prevrow=row
    if row == repeat(["X"],5)
      return true
    end
  end
  if any(columns)
    return true
  end
  return false
end

function play_bingo(boards)
  n_boards = length(boards)÷5
  bingo_board = nothing
  retnum = nothing
  playable_boards = Set(1:n_boards)
  for num in callout_numbers, i in 1:n_boards 
    callout(num,boards)
    if checkbingo(i,boards)
      bingo_board = i
      retnum = num
      break
    end
  end
  return (bingo_board,retnum)
end


function play_bingo_tillone(boards)
  n_boards = length(boards)÷5
  playable_boards = Set(1:n_boards)
  for num in callout_numbers, i in 1:n_boards 
    callout(num,boards)
    if (i in playable_boards) && checkbingo(i,boards)
      pop!(playable_boards,i)
    end
    if (length(playable_boards) == 0)
      return  i,num
    end
  end
  return nothing 
end

function count_score(i,boards)
  sum1=0
  for row in boards[5*i-4:5i]
    for c in row
      if c!="X"
	sum1+=parse(Int,c)
      end
    end
  end
  return sum1
end

bingo,num =play_bingo(boards)
println("first answer :", count_score(bingo,boards)*parse(Int,num))
bingo2,num2 = play_bingo_tillone(boards2)
println("second answer :", count_score(bingo2,boards2)*parse(Int,num2))
