defmodule ArtisanConnectWeb.LandingLive.Index do
  use ArtisanConnectWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    # Sample featured products - replace with actual DB query when ready
    featured_products = [
      %{
        id: 1,
        name: "Traditional Banig Mat",
        description: "Handwoven Filipino sleeping mat",
        price: Decimal.new("1499.99"),
        rating: 4.9,
        review_count: 2182,
        original_price: Decimal.new("2999.99"),
        discount_percent: 50,
        image_url: "/images/products/banig.jpg"
      },
      %{
        id: 2,
        name: "Handcrafted Wooden Serving Tray",
        description: "Narra wood carved serving tray",
        price: Decimal.new("2499.99"),
        rating: 4.8,
        review_count: 1463,
        original_price: Decimal.new("3599.99"),
        discount_percent: 30,
        image_url: "/images/products/tray.jpg"
      }
      # Add more sample products
    ]

    {:ok,
     socket
     |> assign(:featured_products, featured_products)
     |> assign(:current_slide, 0)}
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

      <!-- Featured Products Carousel -->
      <%!-- <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
        <h2 class="text-2xl font-bold text-gray-900 mb-8">Featured Products</h2>
        <div class="product-carousel-container">
          <div class="product-carousel">
            <%= for {product, index} <- Enum.with_index(@featured_products) do %>
              <div class={"product-card #{if @current_slide == index, do: "active", else: ""}"}>
                <img src={product.image_url} alt={product.name} class="w-full h-64 object-cover rounded-lg">
                <div class="mt-4">
                  <h3 class="text-lg font-medium text-gray-900"><%= product.name %></h3>
                  <div class="flex items-center mt-1">
                    <%= for _i <- 1..(5 - trunc(product.rating)) do %>
                      <svg class="w-5 h-5 text-yellow-400" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                      </svg>
                    <% end %>
                    <span class="ml-2 text-sm text-gray-600">(<%= product.rating %>)</span>
                  </div>
                  <p class="mt-2 text-gray-600"><%= product.description %></p>
                  <p class="mt-2 text-xl font-bold text-blue-600">₱<%= format_price(product.price) %></p>
                </div>
              </div>
            <% end %>
          </div>
          <button phx-click="prev_slide" class="prev-btn">❮</button>
          <button phx-click="next_slide" class="next-btn">❯</button>
        </div>
      </div> --%>

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

      <!-- Daily Deals Carousel -->
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
        <div class="flex justify-between items-center mb-6">
          <h2 class="text-2xl font-bold text-gray-900">Amazing deals, updated daily</h2>
          <div class="flex gap-2">
            <button phx-click="prev_slide" class="p-2 rounded-full hover:bg-gray-100">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
              </svg>
            </button>
            <button phx-click="next_slide" class="p-2 rounded-full hover:bg-gray-100">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
              </svg>
            </button>
          </div>
        </div>

        <div class="relative overflow-hidden">
          <div class="flex gap-4 transition-transform duration-300" style={"transform: translateX(-#{@current_slide * 100}%)"}>
            <%= for product <- @featured_products do %>
              <div class="flex-none w-[250px]">
                <div class="group relative">
                  <div class="aspect-square w-full overflow-hidden rounded-lg bg-gray-100">
                    <img
                      src={product.image_url}
                      alt={product.name}
                      class="h-full w-full object-cover object-center group-hover:opacity-75"
                    >
                  </div>
                  <div class="mt-4">
                    <h3 class="text-sm text-gray-700 line-clamp-2">
                      <%= product.name %>
                    </h3>
                    <div class="mt-1 flex items-center">
                      <div class="flex items-center">
                        <%= for _i <- 1..trunc(product.rating) do %>
                          <svg class="w-4 h-4 text-yellow-400" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                          </svg>
                        <% end %>
                        <%= for _i <- 1..(5 - trunc(product.rating)) do %>
                          <svg class="w-4 h-4 text-gray-300" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                          </svg>
                        <% end %>
                        <span class="ml-1 text-sm text-gray-500">(<%= product.review_count %>)</span>
                      </div>
                    </div>
                    <div class="mt-1 flex items-end">
                      <p class="text-lg font-medium text-gray-900">₱<%= format_price(product.price) %></p>
                      <p class="ml-2 text-sm text-gray-500 line-through">₱<%= format_price(product.original_price) %></p>
                      <p class="ml-2 text-sm text-green-600">(<%= product.discount_percent %>% off)</p>
                    </div>
                  </div>
                </div>
              </div>
            <% end %>
          </div>
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

  @impl true
  def handle_event("next_slide", _, socket) do
    current = socket.assigns.current_slide
    total = length(socket.assigns.featured_products) - 1
    new_slide = if current >= total, do: 0, else: current + 1

    {:noreply, assign(socket, :current_slide, new_slide)}
  end

  @impl true
  def handle_event("prev_slide", _, socket) do
    current = socket.assigns.current_slide
    total = length(socket.assigns.featured_products) - 1
    new_slide = if current <= 0, do: total, else: current - 1

    {:noreply, assign(socket, :current_slide, new_slide)}
  end

  defp format_price(price) do
    :erlang.float_to_binary(Decimal.to_float(price), decimals: 2)
  end
end
