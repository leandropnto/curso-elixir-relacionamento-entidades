defmodule Exmeal.Users.Get do
  alias Exmeal.{User, Repo, Error}

  def by_id(id) do
    case Repo.get(User, id) do
      %User{} = user -> {:ok, user}
      nil -> {:error, Error.build_user_not_found_error()}
    end
  end
end
