defmodule ArtisanConnectWeb.LandingLive.Index do
  use ArtisanConnectWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-white">
      <!-- Navigation -->
      <nav class="bg-white border-b border-gray-200 fixed w-full z-30 top-0">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="flex justify-between items-center h-16">
            <div class="flex-shrink-0">
              <span class="text-2xl font-bold text-blue-600">ArtisanConnect</span>
            </div>
            <div class="hidden sm:ml-6 sm:flex sm:items-center space-x-4">
              <.link
                navigate={~p"/users/register"}
                class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700"
              >
                Register
              </.link>
              <.link
                navigate={~p"/users/log_in"}
                class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50"
              >
                Sign in
              </.link>
            </div>
          </div>
        </div>
      </nav>

      <!-- Hero Section -->
      <div class="pt-16">
        <div class="relative">
          <div class="absolute inset-0">
            <img
              class="w-full h-[600px] object-cover"
              src="/images/hero-background.jpg"
              alt="Artisan crafts background"
            />
            <div class="absolute inset-0 bg-gray-500 mix-blend-multiply"></div>
          </div>
          <div class="relative max-w-7xl mx-auto py-24 px-4 sm:py-32 sm:px-6 lg:px-8">
            <h1 class="text-4xl font-extrabold tracking-tight text-white sm:text-5xl lg:text-6xl">
              Discover Unique Artisan Creations
            </h1>
            <p class="mt-6 text-xl text-gray-100 max-w-3xl">
              Connect directly with talented artists and craftspeople. Find one-of-a-kind pieces that tell a story.
            </p>
            <div class="mt-10">
              <.link
                navigate={~p"/users/register"}
                class="inline-flex items-center px-6 py-3 border border-transparent text-base font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700"
              >
                Start Your Journey
              </.link>
            </div>
          </div>
        </div>
      </div>

      <!-- Featured Categories -->
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
        <h2 class="text-2xl font-bold text-gray-900 mb-8">Popular Categories</h2>
        <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
          <%= for {category, image} <- featured_categories() do %>
            <div class="group relative">
              <div class="relative w-full h-80 bg-white rounded-lg overflow-hidden group-hover:opacity-75 sm:aspect-w-2 sm:aspect-h-1 sm:h-64 lg:aspect-w-1 lg:aspect-h-1">
                <img
                  src={image}
                  alt={category}
                  class="w-full h-full object-center object-cover"
                />
              </div>
              <h3 class="mt-6 text-sm text-gray-500">
                <a href="#" class="hover:text-blue-600">
                  <span class="absolute inset-0"></span>
                  <%= category %>
                </a>
              </h3>
            </div>
          <% end %>
        </div>
      </div>

      <!-- Value Proposition -->
      <div class="bg-gray-50">
        <div class="max-w-7xl mx-auto py-16 px-4 sm:px-6 lg:px-8">
          <div class="grid grid-cols-1 gap-y-12 lg:grid-cols-3 lg:gap-x-8">
            <div class="text-center">
              <div class="flex items-center justify-center h-12 w-12 rounded-md bg-blue-600 text-white mx-auto">
                <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 01-9 9m9-9a9 9 0 00-9-9m9 9H3m9 9a9 9 0 01-9-9m9 9c1.657 0 3-4.03 3-9s-1.343-9-3-9m0 18c-1.657 0-3-4.03-3-9s1.343-9 3-9m-9 9a9 9 0 019-9" />
                </svg>
              </div>
              <h3 class="mt-6 text-lg font-medium text-gray-900">Global Artisan Community</h3>
              <p class="mt-2 text-base text-gray-500">Connect with talented artists worldwide</p>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  defp featured_categories do
    [
      {"Handmade Jewelry", "/images/categories/jewelry.jpg"},
      {"Pottery & Ceramics", "/images/categories/pottery.jpg"},
      {"Digital Art", "/images/categories/digital-art.jpg"},
      {"Textile & Fiber Arts", "/images/categories/textile.jpg"},
      {"Wood Crafts", "/images/categories/woodcraft.jpg"},
      {"Paintings", "/images/categories/paintings.jpg"},
      {"Sculptures", "/images/categories/sculptures.jpg"},
      {"Photography", "/images/categories/photography.jpg"}
    ]
  end
end
