class City < ApplicationRecord
  validates :name, presence: {message: 'Please enter your city.'}
  validates :zip_code, format: {with:/\A((0[1-9])|([1-8][0-9])|(9[0-5])|(2[ab]))[0-9]{3}\z/ ,message: "Please enter the 5-digit French zip code."}
  # \A : nothing before
  # \z : nothing after
  # [0-9]{3} : three positions of any digit
  # (([0-8][0-9])|(9[0-5])|(2[ab])) : three possibilites delimited by |
  # each possibility determines two digits
  # first possibility [0-8][0-9] : first position of 0-8 + second position of 0-9
  # second possibility 9[0-5] : first position 9, second position 0-5
  # third possibility 2[ab] : first position 2, second position a or b
  # to sum up
  # either all-digit cps of department 01-89 followed by any three digits
  # or departments 90 - 95 followed by any three digits
  # or the TOM DOM with 2a or ab followed by any digits

  has_many :users
  has_many :rooms
end
