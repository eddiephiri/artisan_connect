defmodule ArtisanConnectWeb.UserLoginLive do
  use ArtisanConnectWeb, :live_view

  def render(assigns) do
    ~H"""
    <main class="mt-0 transition-all duration-200 ease-soft-in-out">
      <section>
        <div class="relative flex items-center p-0 overflow-hidden bg-center bg-cover min-h-75-screen">
          <div class="container z-10">
            <div class="flex flex-wrap mt-0 -mx-3">
              <div class="flex flex-col w-full max-w-full px-3 mx-auto md:flex-0 shrink-0 md:w-6/12 lg:w-5/12 xl:w-4/12">
                <div class="relative flex flex-col min-w-0 mt-32 break-words bg-transparent border-0 shadow-none rounded-2xl bg-clip-border">
                  <div class="p-6 pb-0 mb-0 bg-transparent border-b-0 rounded-t-2xl">
                    <h3 class="relative z-10 font-bold text-transparent bg-gradient-to-tl from-blue-600 to-cyan-400 bg-clip-text">Welcome back</h3>
                    <p class="mb-0">Enter your email and password to sign in</p>
                  </div>
                  <div class="flex-auto p-6">
                    <.form
                      for={@form}
                      id="login_form"
                      action={~p"/users/login"}
                      phx-update="ignore"
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

                      <div class="flex items-center pl-12 mb-0.5 text-left min-h-6">
                        <.input
                          field={@form[:remember_me]}
                          type="checkbox"
                          label="Remember me"
                          class="mt-0.5 rounded-10 duration-250 ease-soft-in-out after:rounded-circle after:shadow-soft-2xl after:duration-250 checked:after:translate-x-5.3 h-5 relative float-left -ml-12 w-10 cursor-pointer appearance-none border border-solid border-gray-200 bg-slate-800/10 bg-none bg-contain bg-left bg-no-repeat align-top transition-all after:absolute after:top-px after:h-4 after:w-4 after:translate-x-px after:bg-white after:content-[''] checked:border-slate-800/95 checked:bg-slate-800/95 checked:bg-none checked:bg-right"
                        />
                      </div>

                      <div class="text-center">
                        <button
                          type="submit"
                          class="inline-block w-full px-6 py-3 mt-6 mb-2 font-bold text-center text-white uppercase align-middle transition-all bg-transparent border-0 rounded-lg cursor-pointer active:opacity-85 hover:scale-102 hover:shadow-soft-xs leading-pro text-xs ease-soft-in tracking-tight-soft shadow-soft-md bg-150 bg-x-25 bg-gradient-to-tl from-blue-600 to-cyan-400 hover:border-slate-700 hover:bg-slate-700 hover:text-white"
                        >
                          Sign in
                        </button>
                      </div>

                      <p class="mt-4 mb-0 leading-normal text-sm">
                        Don't have an account?
                        <.link
                          navigate={~p"/users/register"}
                          class="font-bold text-slate-700"
                        >
                          Sign up
                        </.link>
                      </p>
                    </.form>
                  </div>
                </div>
              </div>
              <div class="w-full max-w-full px-3 lg:flex-0 shrink-0 md:w-6/12">
                <div class="absolute top-0 hidden w-3/5 h-full -mr-32 overflow-hidden -skew-x-10 -right-40 rounded-bl-xl md:block">
                  <div class="absolute inset-x-0 top-0 z-0 h-full -ml-16 bg-cover skew-x-10" style="background-image: url('/images/curved-images/curved6.jpg')"></div>
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
    email = Phoenix.Flash.get(socket.assigns.flash, :email) || ""
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
