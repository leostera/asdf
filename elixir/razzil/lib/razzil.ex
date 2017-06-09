defmodule Razzil do
  @moduledoc """
  Documentation for Razzil.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Razzil.hello
      :world

  """
  def hello do
    :world
  end

  def who_am_i(:good), do: :jean_valjean
  def who_am_i(:bad),  do: :javert?

end
