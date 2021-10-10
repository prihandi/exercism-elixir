defmodule RobotSimulator do
  defstruct direction: nil, position: nil

  @valid_directions [:north, :east, :south, :west]
  @default_direction :north
  @default_position {0, 0}
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ @default_direction, position \\ @default_position) do
    %RobotSimulator{}
    |> set_dir(direction)
    |> set_pos(position)
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(%RobotSimulator{} = robot, instructions) do
    instructions
    |> String.graphemes()
    |> Enum.reduce(robot, &move/2)
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(%RobotSimulator{direction: dir}), do: dir

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(%RobotSimulator{position: pos}), do: pos

  defp set_dir(%RobotSimulator{} = robot, direction) when direction in @valid_directions do
    %RobotSimulator{robot | direction: direction}
  end

  defp set_dir({:error, _} = error, _), do: error
  defp set_dir(_, _), do: {:error, "invalid direction"}

  defp set_pos(%RobotSimulator{} = robot, {x, y} = position)
       when is_integer(x) and is_integer(y) do
    %RobotSimulator{robot | position: position}
  end

  defp set_pos({:error, _} = error, _), do: error
  defp set_pos(_, _), do: {:error, "invalid position"}

  defp move(_letter, {:error, _} = error), do: error
  defp move(letter, %RobotSimulator{} = robot) do
    case {letter, robot} do
      {"R", %{direction: d}} -> set_dir(robot, turn_right(d))
      {"L", %{direction: d}} -> set_dir(robot, turn_left(d))
      {"A", %{direction: :north, position: {x, y}}} -> set_pos(robot, {x, y + 1})
      {"A", %{direction: :east, position: {x, y}}} -> set_pos(robot, {x + 1, y})
      {"A", %{direction: :south, position: {x, y}}} -> set_pos(robot, {x, y - 1})
      {"A", %{direction: :west, position: {x, y}}} -> set_pos(robot, {x - 1, y})
      _ -> {:error, "invalid instruction"}
    end
  end

  defp turn_right(direction) do
    @valid_directions
    |> Enum.find_index(fn x -> x == direction end)
    |> case do
      x when x > 2 -> x - 3
      x -> x + 1
    end
    |> (&Enum.at(@valid_directions, &1)).()
  end

  defp turn_left(direction) do
    @valid_directions
    |> Enum.find_index(fn x -> x == direction end)
    |> case do
      x when x < 1 -> x + 3
      x -> x - 1
    end
    |> (&Enum.at(@valid_directions, &1)).()
  end
end
