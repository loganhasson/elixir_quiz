defmodule Heightmap do
  def generate(size, :perlin), do: generate_perlin(size)
  def generate(size, :diamond_square), do: generate_diamond_square(size)
  def generate(size, :open_simplex), do: generate_open_simplex(size)

  def generate_perlin(size) do
  end

  def generate_diamond_square(size) do
  end

  def generate_open_simplex(size) do
  end
end
