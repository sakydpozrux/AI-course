#!/usr/bin/ruby

require_relative 'src/consts.rb'
require_relative 'src/mdp.rb'


filename = ARGV[0]

if !filename
  puts "You should specify data file in argument"
  puts "Example run: ruby solver.rb example1/e1.data"
end

mdp = MDP.new(filename, absError(), qGamma(), qIterations())

mdp.solveValueIterateAlgorithm
mdp.storePolicyLog
mdp.storeGraph

mdp.solveQLearnAlgorithm
mdp.printQualityDirections
mdp.printQualities

