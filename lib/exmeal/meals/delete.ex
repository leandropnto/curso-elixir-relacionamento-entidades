defmodule Exmeal.Meals.Delete do
  alias Exmeal.{Meal, Repo, Error}
  alias Ecto.Changeset

  def call(id) do
    with %Meal{} = meal <- Repo.get(Meal, id),
         {:ok, _} = result <- Repo.delete(meal) do
      result
    else
      nil ->
        {:error, Error.build_meal_not_found_error()}

      {:error, %Changeset{}} ->
        {:error, Error.build(:internal_server_error, "Error trying delete meal.")}
    end
  end
end
