defmodule Exmeal.Meals.Update do
  alias Exmeal.{Meal, Repo, Error}
  alias Ecto.Changeset

  def call(params) do
    case update(params) do
      {:ok, %Meal{}} = result ->
        result

      nil ->
        {:error, Error.build_meal_not_found_error()}

      {:error, %Changeset{} = changeset} ->
        {:error, Error.build(:bad_request, changeset)}
    end
  end

  defp update(%{"id" => id} = params) do
    with %Meal{} = meal <- Repo.get(Meal, id),
         {:ok, _meal} = result <-
           meal
           |> Meal.changeset(params)
           |> Repo.update() do
      result
    end
  end
end
