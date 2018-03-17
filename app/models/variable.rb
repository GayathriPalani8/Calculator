class Variable < ApplicationRecord
	def self.find_value(value)
		value = Variable.where(name: value.strip!).first;
	end
end
