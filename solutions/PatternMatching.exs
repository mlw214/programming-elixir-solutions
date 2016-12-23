# Chapter 2.
defmodule PatternMatching do
  def problem1() do
    a = [1, 2, 3]
    IO.puts("a = [1, 2, 3] matches")
    a = 4
    IO.puts("a = 4 matches")
    4 = a
    IO.puts("4 = a matches")
    try do
      [a, b] = [1, 2, 3]
      raise "[a, b] = [1, 2, 3] should not have matched"
    rescue
      MatchError -> IO.puts("[a, b] = [1, 2, 3] did not match")
    end
    a = [ [1, 2, 3] ]
    IO.puts("a = [ [1, 2, 3] ] matches")
    [a] = [ [1, 2, 3] ]
    IO.puts("[a] = [ [1, 2, 3] ] matches")
    try do
      [[a]] = [ [1, 2, 3] ]
      raise "[[a]] = [ [1, 2, 3] ] should not have matched"
    rescue
      MatchError -> IO.puts("[[a]] = [ [1, 2, 3] ] did not match")
    end
  end
  
  def problem2() do
    try do
      [a, b, a] = [1, 2, 3]
      raise "[a, b, a] = [1, 2, 3] should not have matched"
    rescue
      MatchError -> IO.puts("[a, b, a] = [1, 2, 3] did not match")
    end
    try do
      [a, b, a] = [1, 1, 2]
      raise "[a, b, a] = [1, 1, 2] should not have matched"
    rescue
      MatchError -> IO.puts("[a, b, a] = [1, 1, 2] did not match")
    end
    [a, b, a] = [1, 2, 1]
    IO.puts("[a, b, a] = [1, 2, 1] matches")
  end

  def problem3() do
    a = 2
    try do
      [a, b, a] = [1, 2, 3]
      raise "[a, b, a] = [1, 2, 3] should not have matched"
    rescue
      MatchError -> IO.puts("[a, b, a] = [1, 2, 3] did not match")
    end
    try do
      [a, b, a] = [1, 1, 2]
      raise "[a, b, a] = [1, 1, 2] should not have matched"
    rescue
      MatchError -> IO.puts("[a, b, a] = [1, 1, 2] did not match")
    end
    a = 1
    IO.puts("a = 1 matches")
    try do
      ^a = 2
      raise "^a = 2 should not have matched"
    rescue
      MatchError -> IO.puts("^a = 2 did not match")
    end
    ^a = 1
    IO.puts("^a = 1 matches")
    ^a = 2 - a
    IO.puts("^a = 2 - a matches")
  end
end