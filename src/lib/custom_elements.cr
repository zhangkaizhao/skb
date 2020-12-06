module CustomElements

  def self.process(doc)
    # XXX Change doc via OOP instead of FP
    elements.each do |element|
      doc = element.process(doc)
    end

    doc
  end

  protected def self.elements
    [CustomElements::RecentlyChangedList]
  end

end
