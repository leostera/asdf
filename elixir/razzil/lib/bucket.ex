defprotocol Bucket do
  def new(data)
  def get
  def put
end

@type 


defmodule Bucket do

  def new(data \\ %{}) do
    Agent.start_link(fn -> data end)
  end

  def get(bucketPid, key) do
    Agent.get(bucketPid, fn(data) -> Map.get(data, key) end)
  end

  def put(bucketPid, key, value) do
    Agent.update(bucketPid, fn(data) -> Map.put(data, key, value) end)
  end

end
