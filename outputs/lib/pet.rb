class Pet
  # comment not attached
  def uploadFile(petId,additionalMetadata,file)
    post(petId,additionalMetadata,file)
  end

  # comment not attached
  def addPet(body)
    post(body)
  end

  # Multiple status values can be provided with comma separated strings
  def findPetsByStatus(status)
    get(status)
  end

  # Multiple tags can be provided with comma separated strings. Use tag1, tag2, tag3 for testing.
  def findPetsByTags(tags)
    get(tags)
  end

  # Returns a single pet
  def getPetById(petId)
    get(petId)
  end

end
