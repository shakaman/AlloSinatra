# encoding: utf-8

module AlloSinatra
  class Confcall
    include Mongoid::Document
    include Mongoid::Timestamps

    field :title,           type: String
    field :phone,           type: Integer
    field :private,         type: Boolean,  default: 0
    field :duration,        type: Integer
    field :author,          type: String
    field :author_email,    type: String

    validates_presence_of :phone
    validates_presence_of :author
    validates_presence_of :author_email
    #validates_uniqueness_of :name
  end
end
