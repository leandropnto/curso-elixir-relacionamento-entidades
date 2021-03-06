defmodule Exmeal.Meals.Get do
  alias Exmeal.{Meal, Repo, Error}

  def by_id(id) do
    case Repo.get(Meal, id) do
      %Meal{} = meal -> {:ok, meal}
      nil -> {:error, Error.build_meal_not_found_error()}
    end
  end
end
