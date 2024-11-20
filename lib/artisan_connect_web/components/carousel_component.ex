defmodule ArtisanConnectWeb.CarouselComponent do
  use Phoenix.Component

  def featured_products(assigns) do
    ~H"""
    <div class="product-carousel-container">
      <div class="product-carousel">
        <%= for {product, index} <- Enum.with_index(@featured_products) do %>
          <div class={"product-card #{if @current_slide == index, do: "active", else: ""}"}>
            <img src={product.image_url} alt={product.name} class="rounded-lg">
            <div class="product-info">
              <h3 class="text-xl font-semibold text-gray-800"><%= product.name %></h3>
              <div class="rating text-yellow-400">
                <%= for _i <- 1..product.rating do %>★<% end %>
                <%= for _i <- 1..(5-product.rating) do %>☆<% end %>
                <span class="text-gray-600">(<%= product.rating %>)</span>
              </div>
              <p class="description text-gray-600"><%= product.description %></p>
              <span class="price text-lg font-bold text-primary">₱<%= format_price(product.price) %></span>
            </div>
          </div>
        <% end %>
      </div>

      <button phx-click="prev_slide" class="prev-btn">❮</button>
      <button phx-click="next_slide" class="next-btn">❯</button>
    </div>
    """
  end

  defp format_price(price) do
    :erlang.float_to_binary(Decimal.to_float(price), decimals: 2)
  end
end
