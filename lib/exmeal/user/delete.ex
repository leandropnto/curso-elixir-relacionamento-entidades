defmodule Exmeal.Users.Delete do
  alias Exmeal.{User, Repo, Error}
  alias Ecto.Changeset

  def call(id) do
    with %User{} = user <- Repo.get(User, id),
         {:ok, _} = result <- Repo.delete(user) do
      result
    else
      nil ->
        {:error, Error.build_user_not_found_error()}

      {:error, %Changeset{}} ->
        {:error, Error.build(:internal_server_error, "Error trying delete user.")}
    end
  end
end
