# encoding: UTF-8
$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'allo_sinatra'

run AlloSinatra::App
