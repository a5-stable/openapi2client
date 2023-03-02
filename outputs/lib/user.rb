class User
  # comment not attached
  def createUsersWithArrayInput(body)
    post(body)
  end

  # comment not attached
  def createUsersWithListInput(body)
    post(body)
  end

  # comment not attached
  def getUserByName(username)
    get(username)
  end

  # comment not attached
  def loginUser(username,password)
    get(username,password)
  end

  # comment not attached
  def logoutUser()
    get()
  end

  # This can only be done by the logged in user.
  def createUser(body)
    post(body)
  end

end
