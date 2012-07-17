# encoding: UTF-8
$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'allosinatra'

AlloSinatra.initialize

run AlloSinatra::App
