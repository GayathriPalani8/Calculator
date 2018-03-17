class CalculatorController < ApplicationController

	def index
	end

	def new
		@result, @variable_name = add_numbers(add_params)
		render :index
	end

	def add_numbers(params)
		values_array = params[:value].split('=');
		variable_name = values_array[0];
		values_to_be_added = values_array[1];
		get_numbers = values_to_be_added.split('+');
		answer = get_sum(get_numbers);
	
		create_update_values(variable_name, answer);
		return answer, variable_name
	end
    
    def get_sum(get_numbers)
    	answer = 0;
    	get_numbers.each_with_index do |value|
		  check_value = Variable.find_value(value);
		  if check_value.present?
		  	value = check_value.number;
		  end
		  answer = answer.to_i + value.to_i;
		end
		return answer
	end

    def create_update_values(variable_name, answer)
    	@variable = Variable.find_value(variable_name);
		if @variable.present?
			Variable.update(@variable.id, name: variable_name, number: answer);
	    else
			Variable.create(name: variable_name, number: answer);
        end
    end

	private
	  def add_params
	    params.require(:calculator).permit(:value)
	  end

end
