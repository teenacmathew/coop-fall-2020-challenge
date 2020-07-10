class EventSourcer
  def initialize()
    @value = 0
    @value_state_array = Array.new()
    @value_state_array << @value
    @current_state_index = 0
  end

  attr_reader :value

  def add(num)
    @value += num
    @value_state_array << @value
    @current_state_index += 1
  end

  def subtract(num)
    @value -= num
    @value_state_array << @value
    @current_state_index += 1
  end

  def undo()
    @current_state_index -= 1 if @current_state_index > 0 
    @value = @value_state_array[@current_state_index]
  end

  def redo()
    @current_state_index += 1 if @current_state_index < @value_state_array.length-1
    @value = @value_state_array[@current_state_index]
  end

  def bulk_undo(amount)
    @current_state_index = ((@current_state_index-amount) > 0) ? (@current_state_index-amount) : 0
    @value = @value_state_array[@current_state_index]
  end

  def bulk_redo(amount)
    @current_state_index = ((@current_state_index+amount) < @value_state_array.length) ? (@current_state_index+amount) : @value_state_array.length-1
    @value = @value_state_array[@current_state_index]
  end
end
