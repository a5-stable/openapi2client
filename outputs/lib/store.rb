class Store
  # comment not attached
  def placeOrder(body)
    post(body)
  end

  # For valid response try integer IDs with value >= 1 and <= 10. Other values will generated exceptions
  def getOrderById(orderId)
    get(orderId)
  end

  # Returns a map of status codes to quantities
  def getInventory()
    get()
  end

end
