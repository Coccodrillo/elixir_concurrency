defmodule Fsm.Ride do
  import Fsm

  defstruct status: :none

  state_keeper :status do

    event :order do
      change from: :none, to: :ordered
    end

    event :en_route do
      change from: :ordered, to: :arriving
    end

    event :pick_up do
      change from: :arriving, to: :picked_up
    end

    event :drop_off do
      change from: :pick_up, to: :dropped_off
    end

    event :finish do
      change from: [:picked_up, :dropped_off], to: :none
    end

    event :cancel do
      change from: [:none, :ordered, :en_route], to: :cancelled
    end

  end
end

# r = %Fsm.Ride{}
# {:ok, r} = r |> Fsm.Ride.order
# r |> Fsm.Ride.en_route