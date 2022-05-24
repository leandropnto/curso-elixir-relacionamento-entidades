defmodule Exmeal.Users.Update do
  alias Exmeal.{Error, Repo, User}
  alias Ecto.Changeset

  def call(params) do
    case update(params) do
      {:ok, %User{}} = result ->
        result

      nil ->
        {:error, Error.build_user_not_found_error()}

      {:error, %Changeset{} = changeset} ->
        {:error, Error.build(:bad_request, changeset)}
    end
  end

  defp update(%{"id" => id} = params) do
    with %User{} = user <- Repo.get(User, id),
         {:ok, _} = result <-
           user
           |> User.changeset(params)
           |> Repo.update() do
      result
    end
  end
end
