defmodule Fsm do

	def handle_state_change(struct, property, changes) do
		current_state = Map.get(struct, property)

		case find_valid_state_change(changes, current_state) do
		{_, to_state} -> {:ok, Map.put(struct, property, to_state)}
		nil         -> :error
		end
	end

	defp find_valid_state_change(changes, to_state) do
		changes |> Enum.reverse |> Enum.find(fn
		{{:any}, _}                      -> true
		{states, _} when is_list(states) -> to_state in states
		{state, _}                       -> state == to_state
		_                                -> false
		end)
	end

	defmacro state_keeper(property, do: block) do
		quote do
			@state_property unquote(property)
			unquote(block)
		end
	end

	defmacro event(name, do: block) do
		quote do
		  @event_change []
		  unquote(block)

		  	def unquote(name)(struct), do: handle_state_change(struct, @state_property, @event_change)
		end
 	end

	defmacro change(from: from, to: to) do
		quote do
			@event_change [{unquote(from), unquote(to)}|@event_change]
		end
	end
end