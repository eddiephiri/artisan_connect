defmodule ArtisanConnectWeb.UserRegistrationLive do
  use ArtisanConnectWeb, :live_view

  alias ArtisanConnect.Accounts.User
  alias ArtisanConnect.Accounts

  def render(assigns) do
    ~H"""
    <main class="mt-0 transition-all duration-200 ease-soft-in-out">
      <section class="min-h-screen mb-32">
        <div class="relative flex items-start pt-12 pb-56 m-4 overflow-hidden bg-center bg-cover min-h-50-screen rounded-xl" style="background-image: url('/images/curved-images/curved14.jpg')">
          <span class="absolute top-0 left-0 w-full h-full bg-center bg-cover bg-gradient-to-tl from-gray-900 to-slate-800 opacity-60"></span>
          <div class="container z-10">
            <div class="flex flex-wrap justify-center -mx-3">
              <div class="w-full max-w-full px-3 mx-auto mt-0 text-center lg:flex-0 shrink-0 lg:w-5/12">
                <h1 class="mt-12 mb-2 text-white">Welcome!</h1>
                <p class="text-white">Create a new account to join our community.</p>
              </div>
            </div>
          </div>
        </div>
        <div class="container">
          <div class="flex flex-wrap -mx-3 -mt-48 md:-mt-56 lg:-mt-48">
            <div class="w-full max-w-full px-3 mx-auto mt-0 md:flex-0 shrink-0 md:w-7/12 lg:w-5/12 xl:w-4/12">
              <div class="relative z-0 flex flex-col min-w-0 break-words bg-white border-0 shadow-soft-xl rounded-2xl bg-clip-border">
                <div class="p-6 mb-0 text-center bg-white border-b-0 rounded-t-2xl">
                  <h5>Register with</h5>
                </div>
                <div class="flex-auto p-6">
                  <.form
                    for={@form}
                    id="registration_form"
                    phx-submit="save"
                    phx-change="validate"
                    phx-trigger-action={@trigger_submit}
                    action={~p"/users/login?_action=registered"}
                    method="post"
                  >
                    <div class="mb-4">
                      <.input
                        field={@form[:email]}
                        type="email"
                        label="Email"
                        required
                        class="text-sm focus:shadow-soft-primary-outline leading-5.6 ease-soft block w-full appearance-none rounded-lg border border-solid border-gray-300 bg-white bg-clip-padding py-2 px-3 font-normal text-gray-700 transition-all focus:border-fuchsia-300 focus:bg-white focus:text-gray-700 focus:outline-none focus:transition-shadow"
                      />
                    </div>

                    <div class="mb-4">
                      <.input
                        field={@form[:password]}
                        type="password"
                        label="Password"
                        required
                        class="text-sm focus:shadow-soft-primary-outline leading-5.6 ease-soft block w-full appearance-none rounded-lg border border-solid border-gray-300 bg-white bg-clip-padding py-2 px-3 font-normal text-gray-700 transition-all focus:border-fuchsia-300 focus:bg-white focus:text-gray-700 focus:outline-none focus:transition-shadow"
                      />
                    </div>

                    <div class="text-center">
                      <button
                        type="submit"
                        class="inline-block w-full px-6 py-3 mt-6 mb-2 font-bold text-center text-white uppercase align-middle transition-all bg-transparent border-0 rounded-lg cursor-pointer active:opacity-85 hover:scale-102 hover:shadow-soft-xs leading-pro text-xs ease-soft-in tracking-tight-soft shadow-soft-md bg-150 bg-x-25 bg-gradient-to-tl from-blue-600 to-cyan-400 hover:border-slate-700 hover:bg-slate-700 hover:text-white"
                      >
                        Sign up
                      </button>
                    </div>

                    <p class="mt-4 mb-0 leading-normal text-sm">
                      Already have an account?
                      <.link
                        navigate={~p"/users/login"}
                        class="font-bold text-slate-700"
                      >
                        Sign in
                      </.link>
                    </p>
                  </.form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </main>
    """
  end

  def mount(_params, _session, socket) do
    changeset = Accounts.change_user_registration(%User{})

    socket =
      socket
      |> assign(trigger_submit: false, check_errors: false)
      |> assign_form(changeset)

    {:ok, socket, temporary_assigns: [form: nil]}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &url(~p"/users/confirm/#{&1}")
          )

        changeset = Accounts.change_user_registration(user)
        {:noreply, socket |> assign(trigger_submit: true) |> assign_form(changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(check_errors: true) |> assign_form(changeset)}
    end
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset = Accounts.change_user_registration(%User{}, user_params)
    {:noreply, assign_form(socket, Map.put(changeset, :action, :validate))}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "user")

    if changeset.valid? do
      assign(socket, form: form, check_errors: false)
    else
      assign(socket, form: form)
    end
  end
end
