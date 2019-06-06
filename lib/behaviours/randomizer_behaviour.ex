defmodule RandomizerBehaviour do
  @callback random_coordinate_pair(Integer, Integer) :: {Integer, Integer}
end
