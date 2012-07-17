# encoding: UTF-8
$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'allo_sinatra'

AlloSinatra.initialize

run AlloSinatra::App
